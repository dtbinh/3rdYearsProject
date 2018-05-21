t_max = 10; 
x_0 = [0;0];
y_d = 5;
%% Dynamics
m = 2;
b = 2;
k = 10;
f = @(t,x,u)[x(2);(1/m)*(-k*x(1)-b*x(2)+u)];    
%% Control law
dy_d = 0;
K_p = 20;
K_i = 10;
K_d = 15;
u = @(t,x,z)K_p*(y_d-x(1))+K_i*z(1)+K_d*(dy_d-x(2));
%% Integration law
f_z = @(t,x,z)[y_d - x(1)];
%% Closed-loop Control system
closedLoop = @(t,s)[f(t,s(1:2),u(t,s(1:2),s(3)));
                    f_z(t,s(1:2),s(3))];
%% Run simulation
[t,s] = ode45(@(t,s)closedLoop(t,s),[0 t_max],[x_0;0]);
x = s(:,1:2);
z = s(:,3);
u = @(t,x,z)K_p*(y_d-x(:,1))+K_i*z(:,1)+K_d*(dy_d-x(:,2));
u = u(t,x,z);
figure
plot(t,u)
figure
subplot(2,1,1)
plot(t,x(:,1),'b');
subplot(2,1,2)
plot(t,x(:,2),'r');
%%