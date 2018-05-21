%Sorawit Inprom
%19/03/2018
%this function is state equation of 2DOF manipulator

function dx = hw6_dynamics(t,x,u,T)
    
m1 = 1.943; % kg
m2 = 1.831;% kg
l1 = 0.1; %m
l2 = 0.33; % m
lc1 = 0.226; % m
lc2 = 0.155; % m
h = 0.17; %m
hc = 0.075; % m
k = 0.29; %m
I2_yy = 0.015; % kg m^2
g = 9.81; % m/s^2
b1 = 0.02;
b2 = 0.1;

q1 = x(1);
q2 = x(2);
qd = x(3:4);
qd1 = x(3);
qd2 = x(4);

D = [ m1+m2 -m2*sin(q2)*(l2 - lc2); 
    -m2*sin(q2)*(l2 - lc2) m2*l2^2 - 2*m2*l2*lc2 + m2*lc2^2 + I2_yy];
C = [ 0 -m2*qd2*cos(q2)*(l2 - lc2); 0 0];
G = [ 0 ; g*m2*cos(q2)*(l2 - lc2)];

qdd = inv(D)*([-b1*qd1 ; -b2*qd2] - C*[qd1 ; qd2] - G + T);
dx = [qd;qdd];

end