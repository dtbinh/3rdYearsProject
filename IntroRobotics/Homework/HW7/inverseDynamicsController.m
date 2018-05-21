%Sorawit Inprom
%25/03/2018
%this function is control policy inverse dynamics controller 

function u = inverseDynamicsController(t,x,q_r,qd_r,qdd_r)
    m1 = 2; % kg
    m2 = 2; % kg
    l1 = 0.1; %m
    l2 = 0.3; % m
    lc1 = 0.2; % m
    lc2 = 0.1; % m
    I2_2_2 = 0.05; % kg m^2
    g = 9.80665; % m/s^2
    k1 = 25;
    k2 = 25;
    
    q = x(1:2); 
    qd = x(2:3);
    
    eq = q_r(t)-x(1:2);
    eqd = qd_r(t)-x(3:4);
    a = qdd_r(t) + k1*eq + k2*eqd;
    
    D = [m1+m2 -m2*(l2-lc2)*sin(q(2)) ; -m2*(l2-lc2)*sin(q(2)) m2*(l2-lc2)^2+I2_2_2];
    C = [0 -m2*(l2-lc2)*cos(q(2))*qd(2) ; 0 0];
    G = [0 ; m2*g*(l2-lc2)*cos(q(2))];
    
    u = D*a + C*qd + G;
end