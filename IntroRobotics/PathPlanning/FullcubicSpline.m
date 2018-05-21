function [T,c] = FullcubicSpline(q,v_1,v_N,v_max,a_max)
%% discription
% N via-points, D dimension
% q:= all configurations [DxN]
% v_1:= initial velocity in each dimenstion [Dx1]
% v_N:= final velocity in each dimenstion [Dx1]
% v_max:= maximum velocity in each dimenstion [Dx1]
% a_max:= maximum acceleration in each dimenstion[Dx1]
% T:= time to finish of each sub-trajectory [1x(N-1)]
% c:= coefficient of cubic polynomial of each subtrajectory in each dimension[4x(N-1)xD]

D = size(q,1); %number of dimension
N = size(q,2); %number of via points

option = optimoptions('fmincon','MaxFunctionEvaluations',1000000,'MaxIterations',100000000);

T = fmincon(@(T)sum(T),ones(N-1,1),[],[],[],[],[],[],@(T)nonlcon(T,q,v_1,v_N,v_max,a_max),option);
[~,c] = ComputeViaPointVel(T,q,v_1,v_N);
    
[t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max);

end

%% nonlinear constraint
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

%% visulization
function [t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max)

D = size(q,1);
N = size(q,2);

t_i = cumsum([0;T(1:end-1)]);
t_v = [];
q_v = [];
qd_v = [];
qdd_v = [];
for i = 1:D
    subplot(3,D,D*(1-1)+i)
%    title('q' + string(i))
    hold on;
    plot([t_i;t_i(end)+T(end)],q(i,:),'ko','linewidth',2)
    grid on;

    subplot(3,D,D*(2-1)+i)
 %   title('qd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*v_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*v_max(i,:),'k--')
    grid on;

    subplot(3,D,D*(3-1)+i)
  %  title('qdd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*a_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*a_max(i,:),'k--')
    grid on;


    for k = 1:N-1
        t = t_i(k):0.01:(t_i(k)+T(k));
        tau = (t-t_i(k));
        q_t = c(:,k,i)'*[ones(size(tau));tau;tau.^2;tau.^3];
        qd_t = c(:,k,i)'*[zeros(size(tau));ones(size(tau));2*tau;3*tau.^2];
        qdd_t = c(:,k,i)'*[zeros(size(tau));zeros(size(tau));2*ones(size(tau));6*tau];
        subplot(3,D,D*(1-1)+i)
        plot(t,q_t)
        subplot(3,D,D*(2-1)+i)
        plot(t,qd_t)
        subplot(3,D,D*(3-1)+i)
        plot(t,qdd_t)

    end
end
end

%% Compute Via-Points Velocity
function [v,c] = ComputeViaPointVel(T,q,v_1,v_N)
    %% Define
    D = size(q,1);
    N = size(q,2);
    v = zeros(D,N);
    c = zeros(4,N-1,D);
    %% 
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
        
end