%Sorawit Inprom
%19/03/2018
% this script is used for generating equation of motion
% use the result from this script as a dynamics for hw6_dynamics by copying
% the result and modify the equation 

syms l1 l2 k h m1 m2 hc lc1 lc2 g real; 
rho = [0;1];
DH_table = [pi/2 l1+k h pi/2 ; pi/2 0 l2 -pi/2];
m = [m1;m2];
cm1 = [-hc ; -lc1; 0];
cm2 = [-lc2 ; 0 ; 0];
cm = [cm1 cm2];
I1 = sym('I1_',[3 3]);
I2 = sym('I2_',[3 3]);
assume(I1,'real');
assume(I2,'real');
I = cat(3,I1,I2);
g_v = [0;g;0];
[D,C,G] = dynamicsMatrices(rho,DH_table,m,cm,I,g_v);