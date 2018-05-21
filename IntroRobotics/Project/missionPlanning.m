%Sorwait Inprom
%6/5/2018
%This funtion use to construct a sequence of pose 

function sequence = missionPlanning
    % sequence := a sequence of Start & Goal poses for each traversal
%% Card     

    card_1 = {[150;275;27],[pi;0;0]};
    card_2 = {[150;-275;27],[pi;0;0]};
    card_3 = {[500;473;800],[pi/2;-pi/2;pi]};
    card_4 = {[380;473;600],[pi/2;-pi/2;pi]};
    card_5 = {[600;473;300],[pi/2;-pi/2;pi]};
    card_6 = {[300;473;825],[pi/2;-pi/2;pi]};
    card_7 = {[300;-473;200],[pi/2;-pi/2;0]};
    card_8 = {[450;-473;500],[pi/2;-pi/2;0]};
    card_9 = {[620;-473;200],[pi/2;-pi/2;0]};
    card_10 = {[620;-473;800],[pi/2;-pi/2;0]};
    
    card_list = {card_1,card_2,card_3,card_4,card_5,card_6,card_7,card_8,card_9,card_10};
    card.lists = card_list;

%% Random integer
    Nc = numel(card.lists);
    for i = 1:Nc
       card.lists{i}{3} = round(9*rand(1));
    end
          
%% Robot's definition
    
    q_limit = [  -0.79    3.93;  %limit joint 1
                 -1.05    0.79;  %limit joint 2
                  -0.5    1.84;  %limit joint 3
                -1.571   1.571;  %limit joint 4
                -1.222   2.269;  %limit joint 5
                -1.571   1.571]; %limit joint 6
    robot.limits =  q_limit;
    robot.DH = [-pi/2,  250.5,    0,  pi/2;
                 pi/2,      0,  500,     0;
                -pi/3,      0,  100, -pi/2;
                    0, -507.2,    0,  pi/2;
                -pi/6,      0,    0, -pi/2;
                    0,   -230,    0,    pi];
    robot.Home = {[0;-340;131],[pi;0;-pi/2],'Home'}; %Home Pose
    robot.Set = {[500;0;500],[0;-pi/2;pi],'Set'}; %Set Pose
    
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
             
%% Sorting

    pos_list = cell(1,(4*Nc)+3);
    N = numel(pos_list);
    pos_list{1} = robot.Home;
    pos_list{2} = robot.Set;
    pos_list{end} = robot.Home;
   
    % bubble sort
    srt_card_list = bubbleSort(card.lists);
    card.srtlists = srt_card_list;

    % insert to sequence
    target_zone = env.targetzone;
    set_pose = robot.Set;
    temp = 1;
    for ind = 3:4:N-1
        pos_list(:,ind:ind+3) = {srt_card_list{temp},set_pose,target_zone{temp},set_pose};
        temp = temp+1;
    end 
    
    for n = 1:N-1
       sequence(n,:) = {pos_list{n},pos_list{n+1}}; 
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