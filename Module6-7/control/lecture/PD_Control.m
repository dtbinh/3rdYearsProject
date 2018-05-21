function u = PD_Control(t,x)

% u = Kp.e + Kd.de P--> drive (over shoot) d-->damp 
% e = yd - y  

y_d = 2;
dy_d = 0;

K_p = 50;
K_d = 15;

u = K_p*(y_d-x(1))+K_d*(dy_d-x(2));

end