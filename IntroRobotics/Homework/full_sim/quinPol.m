function A = quinPol( q_i,q_f,qd_i, qd_f, qdd_i, qdd_f,t_i,dt )
%QUINPOL computes a set of coefficients of quintic polynomial that satisfy
%the given boundary conditions.
%   A = QUINPOL(QI,QF,QDI,QDF,QDDI,QDDf,TI,DT) takes initial configuration
%   QI, final configuration QF, initial velocity QDI, final velocity QDF, 

n = numel(q_i);
t_f = t_i + dt;
In = eye(n);
On = zeros(n);
C = [In t_i*In  t_i^2*In    t_i^3*In    t_i^4*In    t_i^5*In;
     On In      2*t_i*In    3*t_i^2*In  4*t_i^3*In  5*t_i^4*In;
     On On      2*In        6*t_i*In    12*t_i^2*In 20*t_i^3*In;
     In t_f*In  t_f^2*In    t_f^3*In    t_f^4*In    t_f^5*In;
     On In      2*t_f*In    3*t_f^2*In  4*t_f^3*In  5*t_f^4*In;
     On On      2*In        6*t_f*In    12*t_f^2*In 20*t_f^3*In];
b = [q_i;qd_i;qdd_i;q_f;qd_f;qdd_f];
a = C\b;
A = reshape(a,n,6);
end

