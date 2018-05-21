function [coef_all,t_i_all,T_all,card,planning,env,robot] = NMotionPlaning(card_list)
%% Card     

    card_1 = {[700;400;20],[pi;0;0],0};
    card_2 = {[800;0;20],[pi;0;0],19};
    card_3 = {[500;520;200],[pi/2;-pi/2;pi],21};
    card_4 = {[380;480;600],[pi/2;-pi/2;pi],8};
    card_5 = {[600;480;300],[pi/2;-pi/2;pi],1};
    card_6 = {[300;480;825],[pi/2;-pi/2;pi],5};
    card_7 = {[600;-485;100],[pi/2;-pi/2;0],17};
    card_8 = {[450;-480;0],[pi/2;-pi/2;0],29};
    card_9 = {[620;-480;200],[pi/2;-pi/2;0],20};
    card_10 = {[620;-480;800],[pi/2;-pi/2;0],13};
    
    card_list = {card_3};
    card.lists = card_list;
 
%     new_card_list = {};
%     new_card = {};
%     for i = 1:numel(card_list)
%         card_i = card_list{i};
%         ind = 1;
%         for j = 1:numel(card_i);
%            if iscell(card_i{j})
%               x = cell2mat(card_i{j});
%               new_card{ind} = x';
%               ind = ind+1;
%            else
%               new_card{ind} = card_i{j};
%               ind = ind+1 ;
%            end
%         end
%         new_card_list{i} = new_card;
%     end
%     card.lists = new_card_list;

%% Robot's definition

    A = @robotSpace;
    
    q_limit = [  -0.79    3.93;  %limit joint 1
                 -1.05    0.79;  %limit joint 2
                  -0.5    1.84;  %limit joint 3
                -1.571   1.571;  %limit joint 4
                -1.222   2.269;  %limit joint 5
                -1.571   1.571]; %limit joint 6
    initial_velocity = [0;0;0;0;0;0]; %[joint1 ; joint2 ;...;joint6]
    final_velocity = [0;0;0;0;0;0]; %[joint1 ; joint2 ;...;joint6]
    maximum_velocity = [0.5;0.5;0.5;1;1;1];
    maximum_acceleration = [0.25;0.25;0.25;0.5;0.5;0.5];
    robot.space = A;
    robot.vel.v_1 = initial_velocity;
    robot.vel.v_N = final_velocity;
    robot.vel.v_max = maximum_velocity;
    robot.accl.a_max = maximum_acceleration;
    robot.limits =  q_limit;
    robot.DH = [-pi/2,  250.5,    0,  pi/2;
                 pi/2,      0,  500,     0;
                -pi/3,      0,  100, -pi/2;
                    0, -507.2,    0,  pi/2;
                -pi/6,      0,    0, -pi/2;
                    0,   -230,    0,    pi];
    robot.Home = {[0;-340;131],[pi;0;-pi/2],'Home'}; %Home Pose
    robot.Set = {[500;0;500],[0;-pi/2;pi],'Set'}; %Set Pose
    %robot.Set = {[500;0;500],[pi;0.2446;0],'Set'};
    robot.Grip = {[],[],'Grip'};
    
%% workspace

    % total workspace's dimension
    width = 1000;
    length = 1000;
    high = 1000;
    % vertices of workspace in 3D
    workspace = [ -0.2*length, 0.8*length, 0.8*length, -0.2*length, -0.2*length, 0.8*length, 0.8*length, -0.2*length;
                   -0.5*width, -0.5*width,  0.5*width,   0.5*width,  -0.5*width, -0.5*width,  0.5*width,   0.5*width;
                            0,          0,          0,           0,        high,       high,       high,        high];
    env.workspace = workspace; 
    
    env.targetzone = { {[780; 300;700],[0;-pi/2;pi],'T1'},  {[780; 100;700],[0;-pi/2;pi],'T2'},  {[780;-100;700],[0;-pi/2;pi],'T3'},...
                       {[780;-300;700],[0;-pi/2;pi],'T4'},  {[780; 300;500],[0;-pi/2;pi],'T5'},  {[780; 100;500],[0;-pi/2;pi],'T6'},...
                       {[780;-100;500],[0;-pi/2;pi],'T7'},  {[780;-300;500],[0;-pi/2;pi],'T8'},  {[780; 100;300],[0;-pi/2;pi],'T9'},...
                       {[780;-100;300],[0;-pi/2;pi],'T10'} };
    
%% obstacle

    Project_Front = [  0.5*width+20, -0.5*width, -0.5*width, 0.5*width+20; %% (y,z)
                            high,      high,           0,        0]; 
    Project_Front_flag = [  0.5*width-26+40, -0.5*width+26, -0.5*width+26, 0.5*width-26+40; %% (y,z)
                                 high,      high,           26,        26];
    Project_Top = [  0.8*length, 0.8*length, -0.8*length, -0.8*length; %% (x,y)
                      0.5*width+20, -0.5*width,  -0.5*width,   0.5*width+20 ]; 
    Project_Top_flag = [  0.8*length-26, 0.8*length-26, -0.8*length, -0.8*length; %% (x,y)
                      0.5*width-26+40, -0.5*width+26,  -0.5*width+26,   0.5*width-26+40 ]; 
                  
    laser = [700,  700,  590,  590; %(x,y)
              10,  -10,  -10,   10];
    obstacles = {Project_Front,Project_Front_flag,Project_Top,Project_Top_flag,laser};
    env.obstacles = obstacles;
    env.laser = false;
    
%% RRT Law
    Maximum_Eucl_distance = 0.4;
    Maximum_Iteration = 100;
    Number_Random_Config = 60;
    Percentage_Greedness = 70;
    
    RRTLaw.dl = Maximum_Eucl_distance;
    RRTLaw.k = Maximum_Iteration;
    RRTLaw.n = Number_Random_Config;
    RRTLaw.grd = Percentage_Greedness;

%% planning
    planning.RRT = RRTLaw;

%% Sorting

    Nc = numel(card.lists);
tic    
    % bubble sort
    srt_card_list = bubbleSort(card.lists);
    card.srtlists = srt_card_list;
toc    
%% Start Planning 
tic
    p_ind = 1;
    target = env.targetzone;
    while numel(srt_card_list) ~= 0
        if p_ind == 1
            [planning.Path{p_ind},~]=PathPlan(robot.Home,robot.Set,robot,env,RRTLaw,p_ind);
            p_ind = p_ind+1;
        else
            [planning.Path{p_ind},status]=PathPlan(robot.Set,srt_card_list{1},robot,env,RRTLaw,p_ind);
            if ~status
                srt_card_list(1) = [];
            else
                p_ind = p_ind+1;
                %[planning.Path{p_ind},~]=PathPlan(srt_card_list{1},robot.Set,robot,env,RRTLaw,p_ind);
                report_status(1,1,p_ind,srt_card_list{1},robot.Set);
                planning.Path{p_ind} = fliplr(planning.Path{p_ind-1});               
                p_ind = p_ind+1;
                
                [planning.Path{p_ind},~]=PathPlan(robot.Set,target{1},robot,env,RRTLaw,p_ind);            
                p_ind = p_ind+1;
                
                %[planning.Path{p_ind},~]=PathPlan(target{1},robot.Set,robot,env,RRTLaw,p_ind);  
                report_status(1,1,p_ind,target{1},robot.Set);
                planning.Path{p_ind} = fliplr(planning.Path{p_ind-1});   
                p_ind = p_ind+1;
                
                srt_card_list(1) = [];
                target(1) = [];
            end
        end
        
        if numel(srt_card_list) == 0
            %[planning.Path{p_ind},~]=PathPlan(robot.Set,robot.Home,robot,env,RRTLaw,p_ind);
            report_status(1,1,p_ind,robot.Set,robot.Home);
            planning.Path{p_ind} = fliplr(planning.Path{1});
        end
    end
toc
  
 %% Trajectory Generation
 
 tic
    timetofinish = 0;
    N = numel(planning.Path);
    Traject_all = cell(3,N);
    for p_ind = 1:N
        p_ind
        via_point = planning.Path{p_ind};
        [Traject_all{1,p_ind},Traject_all{2,p_ind},Traject_all{3,p_ind}] = TrajectGen(via_point,robot);
        planning.TimetoStart{p_ind} = timetofinish;
        timetofinish = timetofinish + sum(Traject_all{2,p_ind});
        planning.TimetoFinish{p_ind} = timetofinish;  
    end
    planning.Traject = Traject_all;
    planning.TimetoEnd = timetofinish;
toc

    %% transform for python
    %Main(planning)
    [coef_all,t_i_all,T_all] = transformDat(planning);
    
end

%% planning
function [via,status]=PathPlan(start,finish,robot,env,RRTLaw,p_ind)
    [q_init,st_1] = inverseKinematics(robot,start);
    [q_goal,st_2] = inverseKinematics(robot,finish);
    q_init = q_init';
    q_goal = q_goal';
    if (mod(p_ind,4) == 0)||(mod(p_ind,4) == 3), flag_end = 1; 
    else flag_end = 0; end

%    if ((mod(p_ind,4) == 0)|| (mod(p_ind,4) == 1)) && p_ind ~= 1 && p_ind ~= N-1, RRTLaw.dl = 0.4; RRTLaw.grd = 70;
%    else RRTLaw.dl = 0.4; RRTLaw.grd = 70; end

    if ~(st_1 == 1 && st_2 == 1)
        report_status(st_1,st_2,p_ind,start,finish);
        status = 0;
    else
        report_status(st_1,st_2,p_ind,start,finish);
        [T,reach] = buildRRT(robot,env,q_init,q_goal,RRTLaw,flag_end);
        if reach
            index = 1;
            iterater = T.breadthfirstiterator;
            for node = iterater
                if norm(T.Node{node}-q_goal) == 0
                    for j = T.findpath(1,node);
                        via(:,index) = T.Node{j}';
                        index = index+1;
                    end
                    break;
                end
            end
            display('Done!!!')
            status = 1;
        else
            %planning.unReach(temp) = p_ind; temp = temp+1;
            %planning.Path{p_ind}(:,1) = planning.Step{p_ind,2}{1};
            %planning.Path{p_ind}(:,2) = planning.Step{p_ind,2}{2};
            display('Fail!!!')
            via = NaN;
            status = 0;
        end
    end    
    

end

%% transform Data
function [coef_all,t_i_all,T_all] = transformDat(planning)
    Traject_all = planning.Traject(1,:);
    N = numel(Traject_all);  
    coef_all = cell(0);
    t_i_all = cell(0);
    T_all = cell(0);
    
    for p_ind = 1:N
        traject_i = Traject_all{p_ind};
        K = numel(traject_i);
        coef_i = zeros(4,K,6);
        t_i = zeros(K,1);
        T_i = zeros(K,1);
        for k = 1:K
            sub_traject_i = traject_i{k};
            coef_i(:,k,:) = sub_traject_i.coef;
            t_i(k) = sub_traject_i.initTime;
            T_i(k) = sub_traject_i.duration;
        end
        coef_all{p_ind} = coef_i;
        t_i_all{p_ind} = t_i;
        T_all{p_ind} = T_i;
    end
end

%% Build RRT
function [T,reach] = buildRRT(robot,env,q_init,q_goal,Law,flag_end)
    
    T = tree(q_init);
    
    %% Build Tree
    for i = 1:Law.k
        q_rand = Rand_Conf(robot.limits,q_goal,i,Law);
        [q_near,near_node] = Nearest_Node(q_rand,T);
        q_new = New_Conf(q_near,q_rand,Law.dl);
        [q_ok,status] = Colis_Detec(q_new,robot,env,flag_end);
        T = Add_New_Conf(q_new,status,near_node,T); 
        reach = isReach(q_ok,q_goal);
        if reach, break; end
    end    

end

%% RRT function
function q_rand = Rand_Conf(q_lim,q_goal,i,Law)
    k = Law.k;
    n = Law.n;
    greedy = Law.grd;
    
    
    D = size(q_goal,2); %dimension of configuration
    
    for j = 1:D
        q_rand(:,j) = (q_lim(j,2)-q_lim(j,1)).*rand(n,1)+q_lim(j,1);
    end
    if mod(i,floor(k/floor(k*greedy/100))) == 0
        q_rand(n,:) = q_goal;
    end

end

function [q_near,near_node] = Nearest_Node(q_rand,T)
    
    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    q_near = zeros(N,D);
    near_node = zeros(N,1);
    for i = 1:N
        for k = 1:numel(T.Node)
            if k == 1 % assign minimum distance 
                q_near(i,:) = T.get(k);
                near_node(i,1) = k;
                min_dist = norm(q_rand(i,:)-T.get(k));
            else % search new minimum distance
               if  norm(q_rand(i,:)-T.get(k)) <= min_dist
                   q_near(i,:) = T.get(k);
                   near_node(i,1) = k;
                   min_dist = norm(q_rand(i,:)-T.get(k));
               end
            end
        end
    end
    
end

function q_new = New_Conf(q_near,q_rand,l)

    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    q_new = zeros(N,D);
    for i = 1:N
        if norm(q_rand(i,:)-q_near(i,:)) < l
            q_new(i,:) = q_rand(i,:);
        else
            q_new(i,:) = q_near(i,:) + l*(q_rand(i,:)-q_near(i,:))/norm(q_rand(i,:)-q_near(i,:));
        end
    end
end

function [q_ok,status] = Colis_Detec(q_new,robot,env,flag_end)
    N = size(q_new,1); % number of interested configuration
    D = size(q_new,2); % dimension of interested configuration
    
    q_ok = zeros(N,D);
    status = ones(N,1);
    Front_ob = env.obstacles{1};
    Front_ob_flag = env.obstacles{2};
    Top_ob = env.obstacles{3};
    Top_ob_flag = env.obstacles{4};
    laser = env.obstacles{5};
    for i = 1:N
        A = robot.space(q_new(i,:));
        intersect = 0;
        if env.laser
            if flag_end
                for k = 2:numel(A)
                    A_k = A{k};            
                    intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob(1,:),Top_ob(2,:))); %(x,y)
                    intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob(1,:),Front_ob(2,:))); %(y,z)
                    intersect = intersect || any(inpolygon(laser(1,:),laser(2,:),A_k(1,:),A_k(2,:)));
                    if intersect, break; end
                end
            else
                for k = 2:numel(A)-1
                    A_k = A{k};            
                    intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob_flag(1,:),Top_ob_flag(2,:))); %(x,y)
                    intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob(1,:),Front_ob(2,:))); %(y,z)
                    intersect = intersect || any(inpolygon(laser(1,:),laser(2,:),A_k(1,:),A_k(2,:)));
                    if intersect, break; end
                end            
            end
        else
            if flag_end
             for k = 2:numel(A)
                if k ~= numel(A) 
                    A_k = A{k};            
                    intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob_flag(1,:),Top_ob_flag(2,:))); %(x,y)
                    intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob_flag(1,:),Front_ob_flag(2,:))); %(y,z)
                    intersect = intersect || (any(inpolygon(A_k(1,:),A_k(2,:),A{1}(1,:),A{1}(2,:))) && any(inpolygon(A_k(2,:),A_k(3,:),A{1}(2,:),A{1}(3,:))));
                    if intersect, break; end
                else
                    intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob(1,:),Top_ob(2,:))); %(x,y)
                    intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob(1,:),Front_ob(2,:))); %(y,z)
                    intersect = intersect || (any(inpolygon(A_k(1,:),A_k(2,:),A{1}(1,:),A{1}(2,:))) && any(inpolygon(A_k(2,:),A_k(3,:),A{1}(2,:),A{1}(3,:))));
  
                end
             end 
            else
                for k = 2:numel(A)-1
                    A_k = A{k};            
                    intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob_flag(1,:),Top_ob_flag(2,:))); %(x,y)
                    intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob_flag(1,:),Front_ob_flag(2,:))); %(y,z)
                    if intersect, break; end
                end 
            end
        end
        status(i,1) = ~intersect;
        if ~intersect, q_ok(i,:) = q_new(i,:);
        else q_ok(i,:) = NaN; end
    end
 
end

function T = Add_New_Conf(q_new,status,near_node,T)
    N = size(q_new,1); % number of configuration
    
    for i = 1:N
        if status(i,1)
            T = T.addnode(near_node(i,1),q_new(i,:));
        end
    end
end

function reach = isReach(q_new,q_goal)
    N = size(q_new,1);
    reach = false;
    for i = 1:N
        if norm(q_new(i,:)-q_goal) == 0
            reach = true;
            break
        end
    end
end

%% Traject Generation
function [Traject,T,c] = TrajectGen(via_points,robot)
    q = via_points;
    v_1 = robot.vel.v_1;
    v_N = robot.vel.v_N;
    v_max = robot.vel.v_max;
    a_max = robot.accl.a_max;
    [T,c] = cubicSpline(q,v_1,v_N,v_max,a_max);
    t_i = cumsum([0;T(1:end-1)]);
    K = numel(T);
    Traject = cell(1,K);
    for k = 1:K
        traject_k.coef = c(:,k,:);
        traject_k.initTime = t_i(k);
        traject_k.duration = T(k);
        Traject{1,k} = traject_k;
    end
end
%% Cubic Spline
function [T,c] = cubicSpline(q,v_1,v_N,v_max,a_max)

D = size(q,1); %number of dimension
N = size(q,2); %number of via points

option = optimoptions('fmincon','MaxFunctionEvaluations',1000000,'MaxIterations',100000000);

T = fmincon(@(T)sum(T),ones(N-1,1),[],[],[],[],zeros(N-1,1),10*ones(N-1,1),@(T)nonlcon(T,q,v_1,v_N,v_max,a_max),option);
[~,c] = ComputeViaPointVel(T,q,v_1,v_N);
 
end

function [con,con_eq] = nonlcon(T,q,v_1,v_N,v_max,a_max)
D = size(q,1);
N = size(q,2);
[v,c] = ComputeViaPointVel(T,q,v_1,v_N);
    
a = zeros(D,N);
for i = 1:D
    a(i,1) = 2*c(3,1,i);
    for k = 1:N-1
        a(i,k+1) = [2 6*T(k)]*c(3:4,k,i);
    end
end

% nonlinear constraint
% qd-v_max <0
% qdd-a_max <0
% -qd-v_max <0
% -qdd-a_max <0
for k = 1:N
    con(:,k) = [v(:,k)-v_max;a(:,k)-a_max;-v(:,k)-v_max;-a(:,k)-a_max];
end
%con(:,k) = [v-v_max;a-a_max;-v-v_max;-a-a_max];
con_eq = [];
end

function [v,c] = ComputeViaPointVel(T,q,v_1,v_N)
    %% Define
    D = size(q,1);
    N = size(q,2);
    v = zeros(D,N);
    c = zeros(4,N-1,D);
    %% 
    if N > 3
        for i = 1:D
            for k = 1:N-2
                %% A
                D1(1,k) = 2*(T(k)^2*T(k+1)+T(k)*T(k+1)^2);
                if k > 1
                    D2(1,k-1) = T(k-1)^2*T(k); 
                    D3(1,k-1) = T(k)*T(k+1)^2;
                end
                %% b
                b(k,1) = 3*(-T(k+1)^2*q(i,k) - (T(k)^2-T(k+1)^2)*q(i,k+1) + T(k)^2*q(i,k+2));
                if k == 1
                    b(k,1) = b(k,1)-T(k)*T(k+1)^2*v_1(i,1);
                elseif k == N-2
                    b(k,1) = b(k,1)-T(k)^2*T(k+1)*v_N(i,1);
                end
            end
            A = diag(D1)+diag(D2,1)+diag(D3,-1);    
            %% V
            v(i,1) = v_1(i);
            v(i,N) = v_N(i);
            v(i,2:N-1) = A\b;
            %% c    
            for k = 1:N-1
                c(1,k,i) = q(i,k);
                c(2,k,i) = v(i,k);
                c(3,k,i) = (-3*q(i,k)+3*q(i,k+1)-2*T(k)*v(i,k)-T(k)*v(i,k+1))/T(k)^2;
                c(4,k,i) = (2*q(i,k)-2*q(i,k+1)+T(k)*v(i,k)+T(k)*v(i,k+1))/T(k)^3;
            end
        end
    elseif N == 3
        for i = 1:D
            v(i,1) = v_1(i);
            v(i,2) = 3*(-T(2)^2*q(i,1) - (T(1)^2-T(2)^2)*q(i,2) + T(1)^2*q(i,3)) - T(1)*T(2)^2*v_1(i) - T(1)^2*T(2)*v_N(i);
            v(i,3) = v_N(i);
            for k = 1:N-1
                c(1,k,i) = q(i,k);
                c(2,k,i) = v(i,k);
                c(3,k,i) = (-3*q(i,k)+3*q(i,k+1)-2*T(k)*v(i,k)-T(k)*v(i,k+1))/T(k)^2;
                c(4,k,i) = (2*q(i,k)-2*q(i,k+1)+T(k)*v(i,k)+T(k)*v(i,k+1))/T(k)^3;
            end
        end
    else
        for i = 1:D
            v(i,1) = v_1(i);
            v(i,N) = v_N(i);
            for k = 1:N-1
                c(1,k,i) = q(i,k);
                c(2,k,i) = v(i,k);
                c(3,k,i) = (-3*q(i,k)+3*q(i,k+1)-2*T(k)*v(i,k)-T(k)*v(i,k+1))/T(k)^2;
                c(4,k,i) = (2*q(i,k)-2*q(i,k+1)+T(k)*v(i,k)+T(k)*v(i,k+1))/T(k)^3;
            end
        end
    end
end

%% Bubble sort
function n_list = bubbleSort(list)
    Nc = numel(list);
    for step = 1:Nc-1
        for c_ind = 1:Nc-1
            if mod(list{:,c_ind}{3},10) > mod(list{:,c_ind+1}{3},10)
                list(:,c_ind:c_ind+1) = list(:,c_ind+1:-1:c_ind);
            end
        end
    end
    n_list = list;
end

%% Inverse Kinematics 
function [q_can, status] = inverseKinematics(robot,list)
    %% Input
    DH = robot.DH;
    p_e = list{1};
    o_e = list{2};

    %% wrist Pose
    P_w = [RPY(o_e) p_e ; 0 0 0 1]*[1 0 0 0 ; 0 1 0 0 ; 0 0 1 DH(6,2) ; 0 0 0 1]*[0 0 0 1]';
    
    x = P_w(1);
    y = P_w(2);
    z = P_w(3);
    r = P_w'*P_w;

    %% define f1 f2 f3
    f1 = @(x)(DH(4,2)*sin(x)*sin(DH(3,4)) + DH(3,3)*cos(x));
    f2 = @(x)(-DH(4,2)*cos(x)*sin(DH(3,4)) + DH(3,3)*sin(x));
    f3 = @(x)(DH(4,2)*cos(DH(3,4)) + DH(3,2));
    
    %% define k1 k2 k3 k4 k5 k6  
    k1 = @(x)(2*DH(1,3)*(f1(x)+DH(2,3)));
    k1 = @(x)(k1(x) + 2*sin(DH(1,4))*DH(1,2)*(cos(DH(2,4))*f2(x) - sin(DH(2,4))*f3(x)));
    
    k2 = @(x)(2*sin(DH(1,4))*DH(1,2)*(f1(x)+DH(2,3)));
    k2 = @(x)(k2(x) + 2*DH(1,3)*(cos(DH(2,4))*f2(x) - sin(DH(2,4))*f3(x)));
     
    k5 = @(x)(f1(x)^2 + f2(x)^2 + f3(x)^2);
    k5 = @(x)(k5(x) + DH(1,3)^2 + DH(2,3)^2 + DH(1,2)^2 + DH(2,2)^2);
    k5 = @(x)(k5(x) + 2*DH(2,3)*f1(x) + 2*DH(2,2)*sin(DH(2,4))*f2(x) + 2*DH(2,2)*cos(DH(2,4))*f3(x));
    
    k6 = @(x)(cos(DH(1,4))*(sin(DH(2,4))*f2(x) + cos(DH(2,4))*f3(x) + DH(2,2)) + DH(1,2));
   
    %% find Theta3    
    a = (DH(4,2)/DH(3,3))^2 + 1;
    sq = (r - 2*DH(1,2)*(z-DH(1,2))-DH(1,2)^2-DH(2,3)^2-DH(4,2)^2-DH(3,3)^2)/(2*DH(2,3)*DH(3,3));
    b = 2*DH(4,2)/DH(3,3)*sq;
    c = sq^2 - 1;
    
    if b^2-4*a*c >= 0 %% solution found
     %%   
        T3_can = [];
        for i = 1:2
            s3 = Root(a,b,c,i);
            for j = 1:2
                c3 = Mom(s3,j);
                T3 = atan2(s3,c3);
                if verify_q3([0 0 T3])
                    T3_can(i,1) = T3;
                end
            end
        end 

        %% find Theta2
        a = @(x)((f1(x)+DH(2,3))^2 + f2(x)^2);
        b = @(x)(-2*(f1(x)+DH(2,3))*(z - k6(x)));
        c = @(x)((z-k6(x))^2 - f2(x)^2);

        T2_can =[];
        for i = 1:size(T3_can,1)
            T3 = T3_can(i);
            for j = 1:2
                s2 = Root(a(T3),b(T3),c(T3),j);
                for k = 1:2
                    c2 = Mom(s2,k);
                    T2 = atan2(s2,c2);
                    if verify_q2([0 T2 T3])
                       T2_can(i,j) = T2;
                    end
                end
            end
        end

        %% find Theta1
        A = @(x,y)((f1(y)+DH(2,3))*cos(x) - f2(y)*sin(x));

        T1_can = [];
        for i = 1:size(T2_can,1)
            for j = 1:size(T2_can,2)
                T2 = T2_can(i,j);
                T3 = T3_can(i);
                c1 = x/A(T2,T3);
                s1 = y/A(T2,T3);
                T1_can(i,j) = atan2(s1,c1);
            end
        end
        
        %% find Theta 4,5,6
        R_0e = RPY(o_e);

        T_all = zeros([6,8]);
        for i = 1:size(T2_can,1)
            for j = 1:size(T2_can,2)
                T1 = T1_can(i,j);
                T2 = T2_can(i,j);
                T3 = T3_can(i);

                R_03 = [ cos(T2+T3)*cos(T1) , -sin(T1) , -sin(T2+T3)*cos(T1) ;
                         cos(T2+T3)*sin(T1) ,  cos(T1) , -sin(T2+T3)*sin(T1) ;
                                  sin(T2+T3) ,         0 ,           cos(T2+T3) ];
                R_36 = R_03'*R_0e;
                for k = 1:2
                    s5 = (-1)^k*sqrt(R_36(3,1)^2 + R_36(3,2)^2);
                    c5 = -R_36(3,3);

                    T5 = atan2(s5,c5);
                    T6 = atan2(R_36(3,2)/s5, R_36(3,1)/s5);
                    T4 = atan2(R_36(2,3)/s5, R_36(1,3)/s5);

                    T_all(:,4*(i-1)+2*(j-1)+k) = [T1;T2;T3;T4;T5;T6];
                end
            end
        end
        
        for i = 1:size(T_all,2)
            q(:,i) = T_all(:,i) - [DH(1,1);DH(2,1);DH(3,1);DH(4,1);DH(5,1);DH(6,1)];
        end
                
        %% Check joint limit
        q_can = JointLimit(q,robot.limits);
        if isnan(q_can)
            status = 2; %out of joint limit
            q = NaN;
        else
            status = 1; %solution found!
        end
    else 
        q = NaN;
        q_can = NaN;
        status = 0; %No solution!!
    end
    %% extend function
    function out = Mom(xx,n)
        out = (-1)^(n+1)*sqrt(1-xx^2);
    end

    function out = Root(a,b,c,n)
        out = (-b + ((-1)^(n+1))*sqrt(b^2-4*a*c))/(2*a);
    end

    function out = verify_q2(config)
        T = config;
        out = abs((r-k5(T(3))) - (k1(T(3))*cos(T(2)) + k2(T(3))*sin(T(2)))) < 1; 
    end  
    
    function out = verify_q3(config)
        T = config;
        out = abs((r-k5(T(3))) - (2*DH(1,2)*(z-k6(T(3))))) < 1 ;
    end
    
end
 
%% Robot Space
function [A,A_T,A_F,links] = robotSpace(q)
    l1 = 250.5;
    l2 = 500;
    l3 = 100;
    l4 = 507.2;
    l6 = 230;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    q5 = q(5);
    q6 = q(6);
    
%% vertices of links
    link_1 = [  250,   250,  -250,  -250,    250,    250,   -250,   -250; 
                 30,    30,    30,    30, -250.5, -250.5, -250.5, -250.5; 
              265.3,  -317,  -317, 265.3,  265.3,   -317,   -317,  265.3];

    link_2 = [   50,     50,    50,     50,   -570,   -570,   -570,   -570;
               51.5,   51.5,  -126,   -126,   51.5,   51.5,   -126,   -126;
               88.5, -100.9,  88.5, -100.9,   88.5, -100.9,   88.5, -100.9];

    link_3 = [   62,    62,    62,    62,   -150,   -150,   -150,   -150;
                 52,   -52,   -52,   -52,     52,     52,    -52,    -52;
                194,  -100,   194,  -100,    193,   -100,    193,   -100];

    link_4_1 = [  50,    50,   50,    50,   -50,   -50,   -50,    -50;
                 404,   404,  150,   150,   404,   404,   150,    150;
                  97,  -111,   97,  -111,    97,  -111,    97,  -111];
             
    link_4_2 = [  50,    50,   50,   50,   -50,   -50,   -50,   -50;%138 -> 50
                  150,    150,    37,    37,   150,   150,    37,    37;
                   53,   -53,     53,   -53,    53,   -53,    53,   -53];
             
    link_4_3 = [  50,    50,    50,    50,   -50,   -50,   -50,   -50;
                  37,    37,   -17,   -17,    37,    37,   -17,   -17;
                  44,   -44,    44,   -44,    44,   -44,    44,   -44];

    link_5_1 = [   50,    50,    50,    50,    -50,    -50,    -50,    -50;
                 38,  38,   -38,   -38,   38,   38,    -38,    -38;
                 35,  -79,    35,  -79,     35,   -79,     35,   -79];

    link_5_2 = [  50,    50,   50,    50,  -50,   -50,  -50,  -50;
                  38,    38,   -38,    -38,   38,    38,   -38,   -38; %+84
                 -79,  -132,  -79,  -132,  -79,  -132,  -79, -132];
             
    link_6_1 = [   58,    58,    58,    58,    -58,    -58,    -58,    -58;
                   58,    58,   -58,   -58,     58,     58,    -58,    -58;
                    -12,   -38,     -12,   -38,      -12,    -38,      -12,    -38];       
             
    link_6_2 = [  58,    58,    58,    58,   -58,   -58,   -58,   -58;
                  58,    58,   -58,   -58,    58,    58,   -58,   -58;
                 -38,  -152,  -38,  -152,  -38,  -152,  -38,  -152]; 
             
    link_6_e = [   75,    75,    75,    75,    -75,    -75,    -75,    -75;
                   75,    75,   -75,   -75,     75,     75,    -75,    -75;
                   26,     0,    26,     0,     26,      0,     26,      0];
               
    links = {link_1,link_2,link_3,link_4_1,link_4_2,link_4_3,link_5_1,link_5_2,link_6_1,link_6_2,link_6_e};

 %% Forward Kinematics 
    FK_1 = [ cos(q1 - pi/2), 0,  sin(q1 - pi/2),  0;
             sin(q1 - pi/2), 0, -cos(q1 - pi/2),  0;
                          0, 1,               0, l1;
                          0, 0,               0,  1];
    FK_2 = [ cos(q1 - pi/2)*cos(q2 + pi/2), -cos(q1 - pi/2)*sin(q2 + pi/2),  sin(q1 - pi/2), l2*cos(q1 - pi/2)*cos(q2 + pi/2);
             cos(q2 + pi/2)*sin(q1 - pi/2), -sin(q1 - pi/2)*sin(q2 + pi/2), -cos(q1 - pi/2), l2*cos(q2 + pi/2)*sin(q1 - pi/2);
                            sin(q2 + pi/2),                 cos(q2 + pi/2),               0,           l1 + l2*sin(q2 + pi/2);
                                         0,                              0,               0,                                1];
    FK_3 = [ cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3), -sin(q1 - pi/2), - cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) - cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2), l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
             cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3),  cos(q1 - pi/2), - cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) - cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2), l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                           cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2),               0,                                 cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3),                                         l1 + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                       0,               0,                                                                                             0,                                                                                                                                    1];
    FK_4 = [ cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)) - sin(q4)*sin(q1 - pi/2), - cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) - cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2), cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
             cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), - cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) - cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2), sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*cos(q1 - pi/2), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                    cos(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                 cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3),                                                        sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                       l1 - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                          0,                                                                                             0,                                                                                                                              0,                                                                                                                                                                                                                                       1];
    FK_5 = [ - cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)), - cos(q4)*sin(q1 - pi/2) - sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)),   sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
               cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)),   cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), - sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                      sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                         -sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                          cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                       l1 - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                                                                                                                                                            0,                                                                                                                                0,                                                                                                                                                                                                                                                                0,                                                                                                                                                                                                                                       1];
    FK_6 = [ - cos(q6)*(cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) - sin(q6)*(cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))),   cos(q6)*(cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q6)*(cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))), cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - l6*(sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
               sin(q6)*(cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)))), - sin(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)))) - cos(q6)*(cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))), sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l6*(sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2))) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                                                                               cos(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - sin(q4)*sin(q6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                                                                                   sin(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) + cos(q6)*sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                        cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)),                                                                                                                                                              l1 - l6*(cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                                                                                                                                                                                                                                                                                                                 0,                                                                                                                                                                                                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                              0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1];
A_1 = transform(FK_1,link_1);
A_2 = transform(FK_2,link_2);
A_3 = transform(FK_3,link_3);
A_4_1 = transform(FK_4,link_4_1);
A_4_2 = transform(FK_4,link_4_2);
A_4_3 = transform(FK_4,link_4_3);
A_5_1 = transform(FK_5,link_5_1);
A_5_2 = transform(FK_5,link_5_2);
A_6_1 = transform(FK_6,link_6_1);
A_6_2 = transform(FK_6,link_6_2);
A_6_e = transform(FK_6,link_6_e);
A = {A_1,A_2,A_3,A_4_1,A_4_2,A_4_3,A_5_1,A_5_2,A_6_1,A_6_2,A_6_e};

%% Projection
    A_T = {A_1(1:2,:),A_2(1:2,:),A_3(1:2,:),A_4_1(1:2,:),A_4_2(1:2,:),A_4_3(1:2,:),A_5_1(1:2,:),A_5_2(1:2,:),A_6_1(1:2,:),A_6_2(1:2,:),A_6_e(1:2,:)}; %Top
    A_F = {A_1(2:3,:),A_2(2:3,:),A_3(2:3,:),A_4_1(2:3,:),A_4_2(2:3,:),A_4_3(2:3,:),A_5_1(2:3,:),A_5_2(2:3,:),A_6_1(2:3,:),A_6_2(2:3,:),A_6_e(2:3,:)}; %Front  

end

%% Helping function
function visual(planning)
    figure('units','normalized','outerposition',[0 0 1 1])
    view(3);

    for i = 1:size(planning.Step,1)
        plot3([planning.Step{i,2}{1,1}(1) planning.Step{i,2}{1,2}(1)],[planning.Step{i,2}{1,1}(2) planning.Step{i,2}{1,2}(2)],[planning.Step{i,2}{1,1}(3) planning.Step{i,2}{1,2}(3)],'linewidth',2); 
        hold on
        axis equal
        axis([-200 800 -500 500 0 1000]);
        pause(1)
    end
 end
 
function A = transform(T,p)
    A = T(1:3,1:3)*p;
    for i = 1:size(p,2)
        A(:,i) = A(:,i)+T(1:3,4);
    end
end

function R = RPY(act)

   alpha = act(1);
   beta = act(2);
   gramma = act(3);

   R_roll = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha) ];
   R_pitch = [ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
   R_yaw = [ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
   R = R_yaw*R_pitch*R_roll;
        
end

function q_can = JointLimit(q,limit)
    status = [];
    q_can = [];
    for i = 1:size(q,2)
        if all((q(:,i) >= limit(:,1))) && all((q(:,i) <= limit(:,2)))
            status(1,i) = 1;
        else
            status(1,i) = 0;
        end
        
    end
    index = 1;
    for i = 1:size(q,2)
        if status(1,i) == 1
            q_can(:,index) = q(:,i);
            index = index + 1;
        end
    end
    if numel(q_can) == 0
        q_can = NaN;
    end
end

function report_status(st_1,st_2,p_ind,start,finish)
    display(p_ind)
    display(start)
    display(finish)
    if st_1 == 0
        display('NO Solution!! at start Pose')
    elseif st_1 == 1
        display('Solution Found!! at start Pose')
    else
        display('Out of limit!! at start Pose')
    end
    
    if st_2 == 0
        display('NO Solution!! at finish Pose')
    elseif st_2 == 1
        display('Solution Found!! at finish Pose')
    else
        display('Out of limit!! at finish Pose')
    end
end