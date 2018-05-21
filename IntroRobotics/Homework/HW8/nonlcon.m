function [con,con_eq] = nonlcon(T,q,v_1,v_N,v_max,a_max)
D = size(q,1);
N = size(q,2);
[v,c] = computeViaPointVel(T,q,v_1,v_N);
    
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