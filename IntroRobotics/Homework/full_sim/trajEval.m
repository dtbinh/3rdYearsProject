function [q,qd,qdd,t,flag] = trajEval(traj,t)
sub_traj = traj.sub;
t_i = traj.t_i;
T = traj.totalTime;
K = numel(t_i);
time_group = cell(1,K);
indices = cell(1,K);
for j = 1:K
    time_group{j} = [];
    indices{j} = [];
end
flag = 0;

for j = 1:numel(t)
    
    if (t(j)<0) || (t(j)>T)
        flag = 'Some of Evaluation time is out of the range of the trajectory.';
    else
        idx = find(t(j) >=t_i,1,'last');
        time_group{idx} = [time_group{idx} t(j)];
        indices{idx} = [indices{idx} j];
    end
    
end
all_indices = [];
all_time = [];
q = [];
qd = [];
qdd = [];

for j = 1:K
    if ~isempty(time_group{j})
        all_indices = [all_indices indices{j}];
        t_j = time_group{j};
        all_time = [all_time t_j];
        C = sub_traj{j}.coeff;
        q = [q C*[ones(1,numel(t_j));t_j;t_j.^2;t_j.^3;t_j.^4;t_j.^5]];
        qd = [qd C*[zeros(1,numel(t_j));ones(1,numel(t_j));2*t_j;3*t_j.^2;4*t_j.^3;5*t_j.^4]];
        qdd = [qdd C*[zeros(1,numel(t_j));zeros(1,numel(t_j));2*ones(1,numel(t_j));6*t_j;12*t_j.^2;20*t_j.^3]];
    end
end

q = q(:,all_indices);
qd = qd(:,all_indices);
qdd = qdd(:,all_indices);
t = all_time(all_indices);

if isempty(t)
    flag = 'None of evaluation time is in the range of the trajectory.';
end
end