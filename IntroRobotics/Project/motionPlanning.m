%Sorwait Inprom
%6/5/2018
%This function use sampling base method(RRT) to calculate via-points for
%moving from Start pose to Goal pose

function Q = motionPlanning(Start,Goal)
    %Start:= Start Position -> {[x,y,z],[r,p,y]}
    %Goal:= Start Position -> {[x,y,z],[r,p,y]}
    %Q := Set of configuration -> [DxN] matrix
    
%% Robot's definition
    
    q_limit = [  -0.79    3.93;  %limit joint 1
                 -1.05    0.79;  %limit joint 2
                  -0.5    1.84;  %limit joint 3
                -1.571   1.571;  %limit joint 4
                -1.222   2.269;  %limit joint 5
                -1.571   1.571]; %limit joint 6
    robot.space = @robotSpace;
    robot.limits =  q_limit;
    robot.DH = [-pi/2,  250.5,    0,  pi/2;
                 pi/2,      0,  500,     0;
                -pi/3,      0,  100, -pi/2;
                    0, -507.2,    0,  pi/2;
                -pi/6,      0,    0, -pi/2;
                    0,   -230,    0,    pi];

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
    
    env.targetzone = { {[773; 300;700],[0;-pi/2;pi],'T1'},  {[773; 100;700],[0;-pi/2;pi],'T2'},  {[773;-100;700],[0;-pi/2;pi],'T3'},...
                       {[773;-300;700],[0;-pi/2;pi],'T4'},  {[773; 300;500],[0;-pi/2;pi],'T5'},  {[773; 100;500],[0;-pi/2;pi],'T6'},...
                       {[773;-100;500],[0;-pi/2;pi],'T7'},  {[773;-300;500],[0;-pi/2;pi],'T8'},  {[773; 100;300],[0;-pi/2;pi],'T9'},...
                       {[773;-100;300],[0;-pi/2;pi],'T10'} };
    
%% obstacle

    Project_Front = [  0.5*width, -0.5*width, -0.5*width, 0.5*width; %% (y,z)
                            high,      high,           0,        0]; 
    Project_Top = [  0.8*length, 0.8*length, -0.8*length, -0.8*length; %% (x,y)
                      0.5*width, -0.5*width,  -0.5*width,   0.5*width ]; 
    Project_Top_flag = [  0.8*length-26, 0.8*length-26, -0.8*length, -0.8*length; %% (x,y)
                      0.5*width-26, -0.5*width+26,  -0.5*width+26,   0.5*width-26 ]; 
                  
    laser = [700,  700,  590,  590; %(x,y)
              10,  -10,  -10,   10];
    obstacles = {Project_Front,Project_Top,Project_Top_flag,laser};
    env.obstacles = obstacles;
    env.laser = false;
    
%% RRT Law
    Maximum_Eucl_distance = 0.3;
    Maximum_Iteration = 300;
    Number_Random_Config = 40;
    Percentage_Greedness = 60;
    
    RRTLaw.dl = Maximum_Eucl_distance;
    RRTLaw.k = Maximum_Iteration;
    RRTLaw.n = Number_Random_Config;
    RRTLaw.grd = Percentage_Greedness;
    
    planning.RRT = RRTLaw;

%% Start Planning 
tic
if iscell(Start) && iscell(Goal)
    [q_init,~] = inverseKinematics(robot,Start);
    [q_goal,~] = inverseKinematics(robot,Goal);
    q_init = q_init';
    q_goal = q_goal';

    [T,reach] = buildRRT(robot,env,q_init,q_goal,RRTLaw);
    if reach
        index = 1;
        iterater = T.breadthfirstiterator;
        for node = iterater
            if norm(T.Node{node}-q_goal) == 0
                for j = T.findpath(1,node)
                    planning.Path{1}(:,index) = T.Node{j}';
                    index = index+1;
                end
                break;
            end
        end
        disp('Done!!!')
    else
        disp('Fail!!!')
    end
 toc
    Q = planning.Path;
else
    disp('Input must be a cell array of position([x,y,z]) and orientation([row,pitch,yaw])')
    Q = NaN;
end
    
end

%% Build RRT
function [T,reach] = buildRRT(robot,env,q_init,q_goal,Law)
    
    T = tree(q_init);
    
    %% Build Tree
    for i = 1:Law.k
        q_rand = Rand_Conf(robot.limits,q_goal,i,Law);
        [q_near,near_node] = Nearest_Node(q_rand,T);
        q_new = New_Conf(q_near,q_rand,Law.dl);
        [q_ok,status] = Colis_Detec(q_new,robot,env);
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

function [q_ok,status] = Colis_Detec(q_new,robot,env)
    N = size(q_new,1); % number of interested configuration
    D = size(q_new,2); % dimension of interested configuration
    
    q_ok = zeros(N,D);
    status = ones(N,1);
    Front_ob = env.obstacles{1};
    Top_ob = env.obstacles{2};
    Top_ob_flag = env.obstacles{3};
    laser = env.obstacles{4};
    for i = 1:N
        A = robot.space(q_new(i,:));
        intersect = 0;
        for k = 1:numel(A)-1
            A_k = A{k};            
            intersect = intersect || ~all(inpolygon(A_k(1,:),A_k(2,:),Top_ob_flag(1,:),Top_ob_flag(2,:))); %(x,y)
            intersect = intersect || ~all(inpolygon(A_k(2,:),A_k(3,:),Front_ob(1,:),Front_ob(2,:))); %(y,z)
            %intersect = intersect || any(inpolygon(laser(1,:),laser(2,:),A_k(1,:),A_k(2,:)));
            if intersect, break; end
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
                  84,    84,   -38,    -38,   84,    84,   -38,   -38;
                 -79,  -132,  -79,  -132,  -79,  -132,  -79, -132];
             
    link_6_1 = [   58,    58,    58,    58,    -58,    -58,    -58,    -58;
                   58,    58,   -58,   -58,     58,     58,    -58,    -58;
                    0,   -38,     0,   -38,      0,    -38,      0,    -38];       
             
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
function R = RPY(act)

   alpha = act(1);
   beta = act(2);
   gramma = act(3);

   R_roll = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha) ];
   R_pitch = [ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
   R_yaw = [ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
   R = R_yaw*R_pitch*R_roll;
        
end

function A = transform(T,p)
    A = T(1:3,1:3)*p;
    for i = 1:size(p,2)
        A(:,i) = A(:,i)+T(1:3,4);
    end
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