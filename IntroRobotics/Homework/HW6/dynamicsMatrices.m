%Sorawit Inprom
%19/03/2018
%this function use to find Dynamic Matrices in every serial manipulato

function [D,C,G] = dynamicsMatrices(rho,DH_table,m,cm,I,g_v)
%DYNAMICSMATRICES computes necessary matrices for dynamics of a manipulator
%   [D,C,G] = DYNAMICSMATRICES(rho,DH_table,m,cm,I,g_v), given list of
%   joint types "rho",


n = size(DH_table,1);
q = sym('q',[n 1]);
qd = sym('qd',[n 1]);
assume(q,'real');
assume(qd,'real');

H = forwardKinematics(q,rho,DH_table);
J = manipulatorJacobian(q,rho,DH_table);

% Generalized inertia matrix

D = sym(zeros(n));
for i = 1:n

    Si = [eye(3) -skew(H(1:3,1:3,i)*cm(:,i));
          zeros(3,3) eye(3)]; 
    Mc_i = [m(i)*eye(3) zeros(3,3) ;
           zeros(3,3) H(1:3,1:3,i)*I(:,:,i)*H(1:3,1:3,i).' ];
    
    D = D + (Si*J(:,:,i))'*Mc_i*(Si*J(:,:,i));
end

D = simplify(expand(D));

% Generalized Coriolis & Centrifugal matrix
C = sym(zeros(n));
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

C = simplify(expand(C));

% Generalized Gravitational Term
G = sym(zeros(n,1));
for i = 1:n

    G = G+(-J(:,:,i)'*[eye(3) ; skew(H(1:3,1:3,i)*cm(:,i))]*(m(i)*g_v));
end

G = simplify(expand(G));

end
%% Helper Function
function R = skew(r)
R = [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];
end 