% sorawit Inprom
% 8/02/2018
% This Function use to find the forward kinematics that have 3 input
% (configuration of robot, DH parameter of robot, type of robot)
% and it can plot the position of each joint frame if input is numerical 


function [H, H_e, R_e, p_e] = forwardKinematics(q,DH_table,type)

% H := [4 x 4 x n] matrix
% H_e := [4 x 4] matrix
% R_e := [3 x 3] rotation matrix (not homogeneous matrix)
% p_e := column vector [3 x 1]

% q := [n x 1] column vector. can be either numeric or symbolic
% type := [n x 1] column vector. can only be numeric [0 or 1]
% DH_table := [n x 4] matrix. can be either numeric or symbolic

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

%% visualization workspace
if ~strcmp(class(q),'sym')
    
end