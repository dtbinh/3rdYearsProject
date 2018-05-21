function u = goToGoal(t,x,p_g)
%{
Author:Sorrawit Inprom
Date:03/09/2017
Description: Control law for differential Drive
%}

Kp = 10;
V0 = 1;
check = 0.01;

e = atan2(p_g(2)-x(2),p_g(1)-x(1))-x(3);
w = Kp*atan2(sin(e),cos(e));
con = sqrt((p_g(1)-x(1))^2+(p_g(2)-x(2))^2);

if con >= check
    v = V0*con;
else
    v = 0;
end

u = [v;w];
    
end