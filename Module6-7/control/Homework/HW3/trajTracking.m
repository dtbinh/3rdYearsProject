function u = trajTracking(t,x,z,x_d,dx_d)
%{
Author:Sorrawit Inprom
Date:03/09/2017
Description:The control law of this nonlinear system
%}

K_p = 1;

% Modify this part
u = dx_d(t)+K_p*(x_d(t)-x(1))-z*x(1)^2;
    
end