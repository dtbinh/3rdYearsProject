%Sorwait Inprom
%6/5/2018
%This Script is a simple animation of manipulator with given set of time
%stamp and a sequence of configurations

%% Given a set of time stamps and a sequence of configurations 
time_stamps = [1 2 5 8 10 15 30]; % the member in time_stamps must not be zeros 
q_limit = [  -0.79    3.93;  %limit joint 1
             -1.05    0.79;  %limit joint 2
              -0.5    1.84;  %limit joint 3
            -1.571   1.571;  %limit joint 4
            -1.222   2.269;  %limit joint 5
            -1.571   1.571]; %limit joint 6
q = zeros(6,numel(time_stamps));
for j = 1:6
    q(j,:) = (q_limit(j,2)-q_limit(j,1)).*rand(1,numel(time_stamps))+q_limit(j,1);
end

%% Add Home Pose
time_stamps = [0 time_stamps]; % add zeros to time stamps
q = [zeros(6,1),q]; % add home config to sequence
for i = 1:numel(time_stamps)-1;
    T(i,1) = time_stamps(i+1) - time_stamps(i);
end

traj = trajGen(q,T,zeros(6,1),zeros(6,1));
dt = 0.2;
index = 1;   
for t = 0:dt:time_stamps(end)
    tau = t-time_stamps(1);
    q_t(index,1) = t;
    qd_t(index,1) = t;
    qdd_t(index,1) = t;
    [q_t(index,2:7),qd_t(index,2:7),qdd_t(index,2:7)] = trajEval(traj,tau);
    index = index+1;
end

%% animate with simMechanics 
assignin('base','q_t',q_t)
assignin('base','qd_t',qd_t)
assignin('base','qdd_t',qdd_t)

sim('animation',[0,time_stamps(end)])

