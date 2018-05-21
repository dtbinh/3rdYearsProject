%Sorawit Inprom
%09/02/2018
%This Script use to generate and display Forward Kinematics Equation of the
%manipulator 

load Material.mat

[H, H_e, R_e, p_e] = forwardKinematics(q,Changpowbot,type);

Forward_kinematics_Equ = simplify(H_e);
display(Forward_kinematics_Equ);