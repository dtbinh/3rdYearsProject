%Sorwait Inprom
%6/5/2018
%This script is a Full simulation of Manipulator

%% robot specifiacation   
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

%% generate pick&place sequence of start&Goal Pose
Path = missionPlanning;
N = numel(Path(:,1));

Traject_all = cell(1,N);

%% motion planning + Generate Trajectory
TimetoStart = zeros(1,N);
TimetoFinish = zeros(1,N);
for p_ind = 1:N
    Q = motionPlanning(Path{p_ind,1},Path{p_ind,2});
    [traj_p,T] = trajGen_fmincon(Q{1},robot.vel.v_1,robot.vel.v_N,robot.vel.v_max,robot.accl.a_max);
    
    if p_ind > 1
        TimetoStart(p_ind) = TimetoFinish(p_ind-1); 
        TimetoFinish(p_ind) = TimetoFinish(p_ind-1)+sum(T);
    else
        TimetoFinish(p_ind) = sum(T);
    end
    Traject_all(p_ind) = {traj_p};
end

%% animation
simulation_time = sum(TimetoFinish);
index = 1;
for p_ind = 1:numel(Traject_all)    
    for t = TimetoStart(p_ind):0.1:TimetoFinish(p_ind)
        tau = t-TimetoStart(p_ind);
        q_t(index,1) = t;
        qd_t(index,1) = t;
        qdd_t(index,1) = t;
        [q_t(index,2:7),qd_t(index,2:7),qdd_t(index,2:7)] = trajEval(Traject_all{p_ind},tau);
        index = index+1;
    end
end
    
%% animate with simMechanics 
assignin('base','q_t',q_t)
assignin('base','qd_t',qd_t)
assignin('base','qdd_t',qdd_t)

sim('animation',[0,simulation_time])








    