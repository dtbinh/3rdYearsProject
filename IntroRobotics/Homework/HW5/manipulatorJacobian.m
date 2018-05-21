%Sorawit Inprom
%19/02/2018
%this function use to find manipulator Jacobian of robot in any type
%Take input q, type, DH table 
%Output are manipulator Jacobian, linear velocity Jacobian 
%and angular velocity jacobian 

function [J,Jv,Jw] = manipulatorJacobian(q, type, DH_table)
    n = size(DH_table,1);
    [H, ~, ~, p_e] = forwardKinematics(q,DH_table,type);
    z_im1 = [0;0;1];
    o_im1 = [0;0;0];
    o_n = p_e;
    
    for i = 1:n      
        J_v_i = cross(type(i)*z_im1 ,(o_n-o_im1)) + (1-type(i))*z_im1;
        J_w_i = type(i)*z_im1;
        J(:,i) = [J_v_i ; J_w_i];
        
        z_im1 = H(1:3,3,i);
        o_im1 = H(1:3,4,i);
 
    end
    Jv = J(1:3,:);
    Jw = J(4:6,:);

end