%Sorawit Inprom
%10/04/2018
%this function use to generate trajectory of N via-point by using cubic
%polynomial equation that can autonomous genetate intermidiate velocity and
%continuous acceleration based on numerical method

%Decision variable: v_max, a_max, Via-point
%The constraint relate to decision variable: 
    %1. High v_max, a_max can reduce duration time more than low v_max,a_max 
    %2. Duration time relate to different between via-point
%Output of the function is T,C
    %T is time to finish of each sub-trajectory. It dimension is [(N-1)x1]
    %c is coefficient of cubic polynomial equ of each sub-trajectory. It
    %dimension is [4x(N-1)]

function [T,c] = cubicSpline(q,v_1,v_N,v_max,a_max)
% Example: [T,c,q] = cubicSpline([1 2 4 2 6 3 4 7 4 2],0,0,5,3)
N = numel(q);
option = optimoptions('fmincon','MaxFunctionEvaluations',1000000,'MaxIterations',100000000);
T = fmincon(@(T)sum(T),ones(N-1,1),[],[],[],[],[],[],@(T)nonlcon(T,q,v_1,v_N,v_max,a_max),option);
[~,c] = ComputeViaPointVel(T,q,v_1,v_N);
[t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max);

end
%% nonlinear constraint
function [con,con_eq] = nonlcon(T,q,v_1,v_N,v_max,a_max)
N = numel(q);

[v,c] = ComputeViaPointVel(T,q,v_1,v_N);
    

a = zeros(N,1);
a(1) = 2*c(3,1);
for k = 1:N-1
    a(k+1) = [2 6*T(k)]*c(3:4,k);
end

% nonlinear constraint
% qd-v_max <0
% qdd-a_max <0
% -qd-v_max <0
% -qdd-a_max <0

con = [v-v_max;a-a_max;-v-v_max;-a-a_max];
con_eq = [];
end
%% visulization
function [t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max)

N = numel(q);
t_i = cumsum([0;T(1:end-1)]);
t_v = [];
q_v = [];
qd_v = [];
qdd_v = [];
subplot(3,1,1*(1-1)+1)
hold on;
plot([t_i;t_i(end)+T(end)],q,'ko','linewidth',2)
grid on;

subplot(3,1,1*(2-1)+1)
hold on;
plot([0 t_i(end)+T(end)],[1 1]*v_max,'k--')
plot([0 t_i(end)+T(end)],-[1 1]*v_max,'k--')
grid on;

subplot(3,1,1*(3-1)+1)
hold on;
plot([0 t_i(end)+T(end)],[1 1]*a_max,'k--')
plot([0 t_i(end)+T(end)],-[1 1]*a_max,'k--')
grid on;


for k = 1:N-1
    t = t_i(k):0.01:(t_i(k)+T(k));
    tau = (t-t_i(k));
    q_t = c(:,k)'*[ones(size(tau));tau;tau.^2;tau.^3];
    qd_t = c(:,k)'*[zeros(size(tau));ones(size(tau));2*tau;3*tau.^2];
    qdd_t = c(:,k)'*[zeros(size(tau));zeros(size(tau));2*ones(size(tau));6*tau];
    subplot(3,1,1*(1-1)+1)
    plot(t,q_t)
    subplot(3,1,1*(2-1)+1)
    plot(t,qd_t)
    subplot(3,1,1*(3-1)+1)
    plot(t,qdd_t)
    
end
end

%% Compute Via-Points Velocity
function [v,c] = ComputeViaPointVel(T,q,v_1,v_N)
    %% Define
    N = numel(q);
    v = zeros(N,1);
    c = zeros(4,N-1);
    %% 
    for k = 1:N-2
        %% A
        D1(1,k) = 2*(T(k)^2*T(k+1)+T(k)*T(k+1)^2);
        if k > 1
            D2(1,k-1) = T(k-1)^2*T(k); 
            D3(1,k-1) = T(k)*T(k+1)^2;
        end
        %% b
        b(k,1) = 3*(-T(k+1)^2*q(k) - (T(k)^2-T(k+1)^2)*q(k+1) + T(k)^2*q(k+2));
        if k == 1
            b(k,1) = b(k,1)-T(k)*T(k+1)^2*v_1;
        elseif k == N-2
            b(k,1) = b(k,1)-T(k)^2*T(k+1)*v_N;
        end
    end
    A = diag(D1)+diag(D2,1)+diag(D3,-1);
    %% V
    v2_N_1 = A\b;
    for k = 1:N
        if k == 1
            v(k,1) = v_1;
        elseif k == N
            v(k,1) = v_N;
        else
            v(k,1) = v2_N_1(k-1,1);
        end
    end
    %% c    
    for k = 1:N-1
        c(1,k) = q(k);
        c(2,k) = v(k);
        c(3,k) = (-3*q(k)+3*q(k+1)-2*T(k)*v(k)-T(k)*v(k+1))/T(k)^2;
        c(4,k) = (2*q(k)-2*q(k+1)+T(k)*v(k)+T(k)*v(k+1))/T(k)^3;
    end
        
end