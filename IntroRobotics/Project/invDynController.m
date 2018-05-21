%Sorwait Inprom
%6/5/2018
%This function is inverse dynamics controller

function u = invDynController(t,x,q_r,qd_r,qdd_r)
    % t := specific time
    % x := state of robot [12x1] vector
    % q_r := trajectory at spectific time
    % qd_r := velocity at specific time
    % qdd_r := acceleration at specific time
    
    % u := control input for manipulator [6x1] vector

%% parameter
DH = [-pi/2,  250.5,    0,  pi/2;
       pi/2,      0,  500,     0;
                -pi/3,      0,  100, -pi/2;
                    0, -507.2,    0,  pi/2;
                -pi/6,      0,    0, -pi/2;
                    0,   -230,    0,    pi];
rho = [1 1 1 1 1 1];
cm = [[0.3;49.6;82],[355.2;24;0.7],[9.8;0;36.7],[0.1;246;20],[0;13.9;55],[0;0;59]];
m = [9 4.3 1.9 1.7 0.3 0.1];
I1 = [205 -0.1 0.65;-0.1 173 -2.7;0.65 -2.7 87];
I2 = [13 -7.6 -1.4;-7.6 101 0.2;-1.4 0.2 104];
I3 = [15 0 0.7;0 17 0;0.7 0 5.7];
I4 = [32 0 0;0 5 -3;0 -3 29];
I5 = [0.9 0 0;0 0.7 -0.2;0 -0.2 0.5];
I6 = [0.1 0 0;0 0.1 0;0 0 0];
I = cat(3,I1,I2,I3,I4,I5,I6);
g_v = [0;0;-9810];

Kp = diag([10 10 10 10 10 10]);
Kd = diag([10 10 10 10 10 10]);

%% symbolic
q = sym('q',[6,1]);
qd = sym('qd',[6,1]);
assume(q,'real');
assume(qd,'real');

D = generalizedInertiaMatrix(q,rho,DH,m,cm,I);
C = generalizedCoriolis(q,qd,D);
C = eval(subs(C,[q,qd],[x(1:6),x(7:12)]));

%% numeric
q = x(1:6);
qd = x(7:12);

D = generalizedInertiaMatrix(q,rho,DH,m,cm,I);
G = generalizedGravitational(q,rho,DH,m,cm,g_v);
s
a = qdd_r + Kd*(qd_r-qd) + Kp*(q_r-q);
u = D*a + C*qd + G;

end