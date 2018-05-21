function dx = nonlinearDyn(t,x,u,k)
%{
Author:Sorrawit Inprom
Date:03/09/2017
Description:Describes dynamic of the system
%}

% Modify this part
dx = k*x(1)^2+u(1);
end