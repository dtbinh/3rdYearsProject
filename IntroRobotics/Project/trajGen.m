%Sorwait Inprom
%6/5/2018
%This script use to calculate trajectory with specific duration time with
%continuous acceleration by cubic polynomial


function Traject = trajGen(Q,dT,v_1,v_N)
    % Q := a set of via point configurations -> [DxN] matrix
    % T := duration time of each sub-trajectory -> [N-1x1] vector
    % v_1 := initial velocity of each joint -> [Dx1] matrix
    % v_N := final velocity of each joint -> [Dx1] matrix
    
    % Traject := Structer of Trajectory has 3 attributes (coefficient,initial time, duration time)
    [~,c] = ComputeViaPointVel(dT,Q,v_1,v_N);
    t_i = cumsum([0;dT(1:end-1)]);
    K = numel(dT);
    Traject = cell(1,K);
    for k = 1:K
        traject_k.coef = c(:,k,:);
        traject_k.initTime = t_i(k);
        traject_k.duration = dT(k);
        Traject{1,k} = traject_k;
    end
end

%% 
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