%Sorwait Inprom
%6/5/2018
%This function use to calculate Generalized Coriolis Matrix

function C = generalizedCoriolis(q,qd,D) 
    % q := configuration of manipulator [Dx1] vector
    % qd := velocity of manipulator [Dx1] vector
    % D := Inetia Matrix [DxD] matrix
    
    % C := Coriolis Matrix [DxD] matrix
    n = numel(q);
    
    if isa(q,'sym'),C = sym(zeros(n));
    else C = zeros(n); end
        
    for j = 1:n
        for k = 1:n
            for i = 1:n
                PD1 = diff(D(k,j),q(i));
                PD2 = diff(D(k,i),q(j));
                PD3 = diff(D(i,j),q(k));

                C(k,j) = C(k,j)+(PD1+PD2-PD3)*qd(i);
            end
        end
    end
    C = 1/2*C;
end 