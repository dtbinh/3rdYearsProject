%Sorwait Inprom
%6/5/2018
%This function use to calculate Generalized Gravitational Matrix

function G = generalizedGravitational(q,rho,DH_table,m,cm,g_v)
    % q := configuration of manipulator [Dx1] vector
    % rho := type of joints [Dx1] vector
    % DH_table := DH parameter of manipulator [Dx4] matrix
    % m := mass of each link [Dx1]
    % cm := center of mass distance of each link [3xD] matrix
    % I := inetia of each link [3x3xD] matrix
    % g_v := gravitational acceleration w.r.t base frame [3x1] vector
    
    %G := Gravitational Matrix [Dx1] vector
    
    n = size(DH_table,1);
    
    H = forwardKinematics(q,rho,DH_table);
    J = manipulatorJacobian(q,rho,DH_table);
    
    if isa(q,'sym'),G = sym(zeros(n,1));
    else G = zeros(n,1); end       
    
    for i = 1:n
        G = G+(-J(:,:,i)'*[eye(3) ; skew(H(1:3,1:3,i)*cm(:,i))]*(m(i)*g_v));
    end
    
end

function R = skew(r)
R = [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];
end 