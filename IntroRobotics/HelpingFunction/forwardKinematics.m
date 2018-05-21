% sorawit Inprom
% 20/03/2018
% This Function use to find the forward kinematics

function [H, H_e, R_e, p_e] = forwardKinematics(q,DH_table,type)
%% instruction
% H := [4 x 4 x n] matrix
% H_e := [4 x 4] matrix
% R_e := [3 x 3] rotation matrix (not homogeneous matrix)
% p_e := column vector [3 x 1]

% q := [n x 1] column vector. can be either numeric or symbolic
% type := [n x 1] column vector. can only be numeric [0 or 1]
% DH_table := [n x 4] matrix. can be either numeric or symbolic

%% Base Frame with respect to World Frame
    %p_b = [200 500 40]';
    %Base = [eye(3) p_b ; zeros(1,3) 1]; 

%% Main   
    n = size(DH_table,1);

    if ~strcmp(class(q),'sym')
        H = zeros(4,4,n);
    else
        H = sym(zeros(4,4,n));
    end

    for i = 1:n
        if type(i) == 0
            A_i = DHtrans(DH_table(i,1),DH_table(i,2)+q(i),DH_table(i,3),DH_table(i,4));
        elseif type(i) == 1
            A_i = DHtrans(DH_table(i,1)+q(i),DH_table(i,2),DH_table(i,3),DH_table(i,4));
        end

        if i > 1
            H(:,:,i) = H(:,:,i-1)*A_i;
        else
            H(:,:,i) = A_i;
        end
    end
    H_e = H(:,:,end);
    R_e = H_e(1:3,1:3);
    p_e = H_e(1:3,4);
end

%% Helping function

function T = DHtrans(par1,par2,par3,par4)
    T = (rot('z',par1));
    T = T*(trans('z',par2));
    T = T*(trans('x',par3));
    T = T*(rot('x',par4));
end

function H = rot(axis, angle)
    if axis == 'x'
        H = [1 0 0 0 ; 0 cos(angle) -sin(angle) 0 ; 0 sin(angle) cos(angle) 0 ; 0 0 0 1];
    elseif axis == 'y'
        H = [cos(angle) 0 sin(angle) 0 ; 0 1 0 0 ; -sin(angle) 0 cos(angle) 0 ; 0 0 0 1];
    elseif axis == 'z'
        H = [cos(angle) -sin(angle) 0 0 ; sin(angle) cos(angle) 0 0 ; 0 0 1 0 ; 0 0 0 1];    
    else
        H = 'error';
    end
end

function H = trans(axis, dist)
    if axis == 'x'
        H = [1 0 0 dist ; 0 1 0 0 ; 0 0 1 0 ; 0 0 0 1];
    elseif axis == 'y'
        H = [1 0 0 0 ; 0 1 0 dist ; 0 0 1 0 ; 0 0 0 1];
    elseif axis == 'z'
        H = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 dist ; 0 0 0 1];    
    else
        H = 'error';
    end
end