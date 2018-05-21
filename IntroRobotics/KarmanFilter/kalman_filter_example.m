t_f = 100;
dt = 0.01;
t = 0:dt:t_f;
N = numel(t);

n = 3; %num of state
m = 2; %num of input
p = 3; %num of output
 
x = zeros(n,N-1);
x_e = zeros(n,N-1);
P = zeros(n,n,N-1);
u = zeros(m,N-1);
y = zeros(p,N-1);

%% Initial Conditions

x(:,1) = [0.5;-0.5;pi/6];
x_e(:,1) = [0;0;0]; %estimated state
P(:,:,1) = 10*eye(n); %convariance --> very not sure(very high)

%% Sensor location
x_a = -5;
y_a = 0;
x_b = 5;
y_b = 2.5;
x_c = 3;
y_c = -2.5;

% Model Description
f = @(t,x,u)[u(1)*cos(x(3));u(1)*sin(x(3));u(2)];
g = @(t,x,u)[(x(1)-x_a)^2+(x(2)-y_a)^2;(x(1)-x_b)^2+(x(2)-y_b)^2;(x(1)-x_c)^2+(x(2)-y_c)^2];
A  = @(t,x,u)[0 0 -u(1)*sin(x(3)); 0 0 u(1)*cos(x(3)); 0 0 0];
B = @(t,x,u)[cos(x(3)) 0 ; sin(x(3)) 0; 0 1];
C = @(t,x,u)[2*(x(1)-x_a) 2*(x(2)-y_a) 0;2*(x(1)-x_b) 2*(x(2)-y_b) 0;2*(x(1)-x_c) 2*(x(2)-y_c) 0 ];
D = @(t,x,u)zeros(p,m);

% Goal & control paraameter
p_g = [-3;-1.5]; %%%%%%%%%%%
K_p = 105;

%% simulation
for k = 1:N-1
%% Control Law 
    
u(:,k) = goToGoal(t(k),x_e(:,k),p_g,K_p);

%% actual dynamics

k_1 = f(t(k),x(:,k),u(:,k));
k_2 = f(t(k)+dt/2,x(:,k)+k_1*dt/2,u(:,k));
k_3 = f(t(k)+dt/2,x(:,k)+k_2*dt/2,u(:,k));
k_4 = f(t(k)+dt,x(:,k)+k_3*dt,u(:,k));

x(:,k+1) = x(:,k) + (k_1+2*k_2+2*k_3+k_4)*dt/6;
noise = 0.51*(rand(p,1)-0.5);


y(:,k) = g(t(k),x(:,k),u(:,k))+noise;
%% Estimator

F_k = eye(n)+A(t(k),x_e(:,k),u(:,k))*dt;
H_k = C(t(k),x_e(:,k),u(:,k));

t_k = t(k);
x_k = x_e(:,k);
y_k = y(:,k);
u_k = u(:,k);
P_k = P(:,:,k);
Q = 1*eye(3);
R = 0.1*eye(p);

 % Prediction
 x_predict = x_k + f(t_k,x_k,u_k)*dt;
 
 P_predict = F_k*P_k*F_k.' + Q;
 
 % Correction
 
 K = P_predict*H_k.'*inv(H_k*P_predict*H_k.' + R);
 x_e(:,k+1) = x_predict + K*(y_k-g(t_k,x_predict,u_k));
 P(:,:,k+1) = P_predict - K*(H_k*P_predict*H_k.' + R)*K.';

end

%% Visualization
subplot(3,2,[1 3 5])
plot(x(1,:),x(2,:),'--')
hold on;
plot(x_e(1,1:50:end-1),x_e(2,1:50:end-1),'*')
plot(x_e(1,end),x_e(2,end),'o','linewidth',5)

subplot(3,2,2)
plot(t(1:50:end),x(1,1:50:end),'--');
hold on;
plot(t(1:50:end),x_e(1,1:50:end),'*')

subplot(3,2,4)
plot(t(1:50:end),x(2,1:50:end),'--');
hold on;
plot(t(1:50:end),x_e(2,1:50:end),'*')

subplot(3,2,6)
plot(t(1:50:end),x(3,1:50:end),'--');
hold on;
plot(t(1:50:end),x_e(3,1:50:end),'*')
