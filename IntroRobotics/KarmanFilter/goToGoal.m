function u = goToGoal(t,x,p_g,K_p)
ep = 0.1;
v_0 = 1;
v = v_0*(sqrt((p_g(1)-x(1))^2+(p_g(2)-x(2))^2)>=ep);
e = atan2(p_g(2)-x(2),p_g(1)-x(1))-x(3);
w = K_p*atan2(sin(e),cos(e))*(sqrt((p_g(1)-x(1))^2+(p_g(2)-x(2))^2)>=ep);
u = [v;w];
end