function [v,c] = computeViaPointVel(T,q,v_1,v_N)
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
                b(k,1) = b(k,1)-T(k)*T(k+1)^2*v_1(i);
            elseif k == N-2
                b(k,1) = b(k,1)-T(k)^2*T(k+1)*v_N(i);
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