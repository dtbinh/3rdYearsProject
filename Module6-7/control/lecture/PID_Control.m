function u = PID_Control(t,x,z,y_d)

dy_d = 0;

K_p = 50;
K_i = 30;
K_d = 15;

u = K_p*(y_d-x(1))+K_i*z(1)+K_d*(dy_d-x(2));

end