function dx = mdsDynamics(t,x,u)

m = 2;
b = 2;
k = 10;

dx = [x(2) ; (1/m)*(-k*x(1)-b*x(2)+u)];

end