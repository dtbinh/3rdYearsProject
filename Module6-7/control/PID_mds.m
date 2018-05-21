t_max = 10; 
x_0 = [0;0];

y_d = 5;

closedLoop = @(t,s)[mdsDynamics(t,s(1:2),PID_Control(t,s(1:2),s(3),y_d));
                    integration_law(t,s(1:2),s(3),y_d)];
                
[t,s] = ode45(@(t,s)closedLoop(t,s),[0 t_max],[x_0;0]);
x = s(:,1:2);
subplot(2,1,1)
plot(t,x(:,1),'b');
subplot(2,1,2)
plot(t,x(:,2),'r');