%Sorwait Inprom
%6/5/2018
%This function use to calculate Generalized Inertia Matrix

function D = generalizedInertiaMatrix(q,rho,DH_table,m,cm,I)
    % q := configuration of manipulator [Dx1] vector
    % rho := type of joints [Dx1] vector
    % DH_table := DH parameter of manipulator [Dx4] matrix
    % m := mass of each link [Dx1]
    % cm := center of mass distance of each link [3xD] matrix
    % I := inetia of each link [3x3xD] matrix

    % D := Inertia Matrix [DxD] matrix
    n = size(DH_table,1);

    H = forwardKinematics(q,rho,DH_table);
    J = manipulatorJacobian(q,rho,DH_table);
    
    if isa(q,'sym')
       D = sym(zeros(n)); 
    else
       D = zeros(n);
    end
    
    for i = 1:n
        Si = [eye(3) -skew(H(1:3,1:3,i)*cm(:,i));
              zeros(3,3) eye(3)]; 
        Mc_i = [m(i)*eye(3) zeros(3,3);
               zeros(3,3) H(1:3,1:3,i)*I(:,:,i)*H(1:3,1:3,i).' ];

        D = D + (Si*J(:,:,i))'*Mc_i*(Si*J(:,:,i));
    end
    %if isa(q,'sym')
    %   D = simplify(D); 
    %end
    
end

function R = skew(r)
    R = [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];
end 