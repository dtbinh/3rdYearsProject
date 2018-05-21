function [dx, y] = DC_Motor(t,x,u,tau,D,k,varargin)
%2.) Define a model for estimation
dx = [  x(2);
        (-1/tau)*(x(2)+D*x(1)+k*u(1))];
y = x(1);

end
