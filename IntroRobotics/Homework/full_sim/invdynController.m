function u = invdynController(t,x,traj,K_P,K_D)
[q_r,qd_r,qdd_r,t,flag] = trajEval(traj,t);
g = 9.80665;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
lc1 = 0.5;
lc2 = 0.5;
Izz1 = 0.1;
Izz2 = 0.1;

n = round(numel(x)/2);

q = x(1:n);
q1 = q(1);
q2 = q(2);

qd = x(n+1:end);
qd1 = qd(1);
qd2 = qd(2);

a_q = qdd_r + K_D*(qd_r-qd) + K_P*(q_r-q);

D = [   m2*l1^2 + 2*m2*cos(q2)*l1*lc2 + m1*lc1^2 + m2*lc2^2 + Izz1 + Izz2, m2*lc2^2 + l1*m2*cos(q2)*lc2 + Izz2;
        m2*lc2^2 + l1*m2*cos(q2)*lc2 + Izz2,                     m2*lc2^2 + Izz2];
C = [ -l1*lc2*m2*qd2*sin(q2), -l1*lc2*m2*sin(q2)*(qd1 + qd2);
        l1*lc2*m2*qd1*sin(q2),                              0];
G = [g*(l1*m2*sin(q1) + lc1*m1*sin(q1) + lc2*m2*sin(q1 + q2));
                                    g*lc2*m2*sin(q1 + q2)];
u = D*a_q + C*qd + G;
end