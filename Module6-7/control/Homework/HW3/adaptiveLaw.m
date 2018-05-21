function dz = adaptiveLaw(t,x,z,x_d)
%{
Author:Sorrawit Inprom
Date:03/09/2017
Description:To described the adaptive law and return output is rate of
change of the integration variable
%}

K_a = 50;

% Modify this part

dz = -K_a*x(1)^2*(x_d(t)-x(1));
    
end