%Sorawit Inprom
%19/03/2018
%this function is state equation of Dynamics of 2DOF manipulator

function dx = dyn_hw7(t,x,u)
    
m1 = 2; % kg
m2 = 2; % kg
l1 = 0.1; %m
l2 = 0.3; % m
lc1 = 0.2; % m
lc2 = 0.1; % m
I2_2_2 = 0.05; % kg m^2
g = 9.80665; % m/s^2
b1 = 0.02;
b2 = 0.1;

q1 = x(1);
q2 = x(2);
qd = x(3:4);
qd1 = x(3);
qd2 = x(4);

D = [ m1+m2 -m2*sin(q2)*(l2 - lc2); 
    -m2*sin(q2)*(l2 - lc2) m2*l2^2 - 2*m2*l2*lc2 + m2*lc2^2 + I2_2_2];
C = [ 0 -m2*cos(q2)*(l2 - lc2)*qd2; 0 0];
G = [ 0 ; m2*g*cos(q2)*(l2 - lc2)];

qdd = inv(D)*([-b1*qd1 ; -b2*qd2] - C*[qd1 ; qd2] - G + u);
dx = [qd;qdd];

end