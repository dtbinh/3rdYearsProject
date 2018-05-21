function traj = trajGen(Q,Qd,Qdd,dT)
%TRAJGEN generates a complete trajectory based on the given via points
%   T = TRAJGEN(Q,QD,QDD,DT) takes a sequence of via point configurations 
%   Q, via point velocity Qd, via point acceleration Qdd, and durations of
%   each sub-trajectory DT , then generates a trajectory T using quintic
%   polynomial.

K = size(Q,2)-1;
sub_traj = cell(1,K);
Q_i = Q(:,1:end-1);
Q_f = Q(:,2:end);

Qd_i = Qd(:,1:end-1);
Qd_f = Qd(:,2:end);

Qdd_i = Qdd(:,1:end-1);
Qdd_f = Qdd(:,2:end);

t_i = zeros(1,K);
for j = 1:K
    A = quinPol(Q_i(:,j),Q_f(:,j),Qd_i(:,j),Qd_f(:,j),Qdd_i(:,j),Qdd_f(:,j),t_i(j),dT(j));
    sub_traj{j} = subTrajectory(A,t_i(j),dT(j));
    if j <K
    t_i(j+1) = t_i(j) + dT(j);
    end
end

traj.sub = sub_traj;
traj.t_i = t_i;
traj.totalTime = t_i(end)+dT(end);

end