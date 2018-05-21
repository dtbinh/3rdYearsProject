function dx = differentialDrive(t,x,u)
%{
Author:Sorrawit Inprom
Date:03/09/2017
Description:this is funtion to describes the dynamics of the system and the
output of the function is the rate of change of state variables
%}

%Modify this part
dx = [u(1)*cos(x(3)) ; u(1)*sin(x(3)) ; u(2)];
    
end