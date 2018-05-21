syms g
m = sym('m',[6,1]);
cm_x = sym('cm_x',[6,1]);
cm_y = sym('cm_y',[6,1]);
cm_z = sym('cm_z',[6,1]);
cm = sym(zeros(3,6));
cm = [[cm_x(1);cm_y(1);cm_z(1)] [cm_x(2);cm_y(2);cm_z(2)] [cm_x(3);cm_y(3);cm_z(3)] [cm_x(4);cm_y(4);cm_z(4)] [cm_x(5);cm_y(5);cm_z(5)] [cm_x(6);cm_y(6);cm_z(6)]];
I1 = sym('I1_',[3 3]);
I2 = sym('I2_',[3 3]);
I3 = sym('I3_',[3 3]);
I4 = sym('I4_',[3 3]);
I5 = sym('I5_',[3 3]);
I6 = sym('I6_',[3 3]);
assume(I1,'real');
assume(I2,'real');
assume(I3,'real');
assume(I4,'real');
assume(I5,'real');
assume(I6,'real');
I = cat(3,I1,I2,I3,I4,I5,I6);
g_v = [0;0;-g];

l = sym('l',[6,1]);
pi = sym('pi');
DH = [-pi/2 l(1) 0 pi/2 ;
       pi/2 0 l(2) 0;
       -pi/3 0 l(3) -pi/2;
       0 -l(4) 0 pi/2;
       -pi/6 l(5) 0 -pi/2;
       0 -l(6) 0 pi];
rho = [1;1;1;1;1;1];

[D,C,G] = dynamicsMatrices(rho,DH,m,cm,I,g_v);