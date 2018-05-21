t_max = 10; 
x_0 = [5;0];
[t,x] = ode45(@(t,x)mdsDynamics(t,x,0),[0 t_max],x_0);
subplot(2,1,1)
plot(t,x(:,1),'b');
subplot(2,1,2)
plot(t,x(:,2),'r');