function simMassDamperSpring

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
K_i = 30;
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
%% Animation
H = 4;
W = 5;
dw = 18;
step = 2;
n = 8;
for i = 1:step:numel(t)-step
    d = x(i,1);
    subplot(2,2,[1 2])
    hold on;
    h1 = plot([d-W/2 d+W/2],[0 0],'k','linewidth',3);
    h2 = plot([d+W/2 d+W/2],[0 H],'k','linewidth',3);
    h3 = plot([d+W/2 d-W/2],[H H],'k','linewidth',3);
    h4 = plot([d-W/2 d-W/2],[H 0],'k','linewidth',3);
    x_s = -dw:0.1:(d-W/2);
    f = n/(d-W/2+dw);
    y_s = H/4+H/8*sin(2*pi*f*(x_s+dw));
    h_s = plot(x_s,y_s,'b','linewidth',3);
    
    h5 = plot([-dw -dw*9/16],[H*3/4 H*3/4],'r','linewidth',3);
    h6 = plot([d-W/2 d-W/2-dw/4],[H*3/4 H*3/4],'r','linewidth',3);
    h7 = plot([d-W/2-dw/4 d-W/2-dw/4],[H*3/4+H/4 H*3/4-H/4],'r','linewidth',3);
    h8 = plot([d-W/2-dw/4 d-W/2-dw*11/16],[H*3/4+H/4 H*3/4+H/4],'r','linewidth',3);
    h9 = plot([d-W/2-dw/4 d-W/2-dw*11/16],[H*3/4-H/4 H*3/4-H/4],'r','linewidth',3);
    h10 = plot([-dw*9/16 -dw*9/16],[H*3/4+H/8 H*3/4-H/8],'r','linewidth',3);
    
    plot([-dw -dw],[0 2*H],'k','linewidth',3);
    plot([-1.25*dw 10],[0 0],'k','linewidth',3);
    
    grid on;
    axis equal
    axis([-1.25*dw 10 -1 2*H])
    xlabel('z')
    
    subplot(2,2,3)
    hold on;
    plot([t(i+step) t(i)],[x(i+step,1) x(i,1)],'b');
    grid on;
    plot([0 t(end)],[0 0],'k')
    axis([0 t(end) min(x(:,1)) max(x(:,1))]);
    ylabel('x_1')
    xlabel('t')
    
    subplot(2,2,4)
    hold on;
    plot([t(i+step) t(i)],[x(i+step,2) x(i,2)],'r');
    grid on;
    plot([0 t(end)],[0 0],'k')
    axis([0 t(end) min(x(:,2)) max(x(:,2))]);
    pause(t(i+step)-t(i));
    ylabel('x_2')
    xlabel('t')
    
    if i <numel(t)-step
    delete(h1)
    delete(h2)
    delete(h3)
    delete(h4)
    delete(h5)
    delete(h6)
    delete(h7)
    delete(h8)
    delete(h9)
    delete(h10)
    delete(h_s)
    end
end

end

function dx = massDamperSpring(t,x,u)
m = 2;
b = 2;
k = 10;

dx = [x(2);(-k*x(1)-b*x(2)+u)/m];
end