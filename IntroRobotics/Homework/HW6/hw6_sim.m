%Sorawit Inprom
%19/03/2018
%this script use to simulate 2 DOG manipulator

l1 = 0.1; %m
l2 = 0.33; % m
lc1 = 0.226; % m
lc2 = 0.155; % m
h = 0.17; %m
hc = 0.075; % m
k = 0.29; %m

rho = [0;1];
DH_table = [pi/2 l1+k h pi/2 ; pi/2 0 l2 -pi/2];
cm1 = [-hc ; -lc1; 0];
cm2 = [-lc2 ; 0 ; 0];
t_max = 10;
x_init = [0;0;0;0];
u = @(t,x)[0;0];
T = [0;0];
[t,x] = ode45(@(t,x)hw6_dynamics(t,x,u,T),[0 t_max],x_init);

q = x(:,1:2)';

hold on;
step = 5;
for i = 1:step:numel(t)-step
    q_i = q(:,i);
    H_i = forwardKinematics(q_i,rho,DH_table);
    
    p_0 = zeros(3,1);
    p_1 = H_i(1:3,4,1);
    p_2 = H_i(1:3,4,2);
    R_1 = H_i(1:3,1:3,1);
    R_2 = H_i(1:3,1:3,2);
    
    link0 = [p_0 p_1+[0;-h;-k-l1]];
    link1 = [p_1 p_1+[0;0;-k] p_1+[0;-h;-k] p_1+[0;-h;-k-l1]];
    link2 = [p_1 p_2];
    p_c1 = p_1 + R_1*cm1;
    p_c2 = p_2 + R_2*cm2;
    
    subplot(2,3,[1 4]);
    view(3)
    hold on;
    if(i~=1)&&(i<numel(t)-step)
        
        delete(h_link0);
        delete(h_link1);
        delete(h_link2);
        delete(h_mass1);
        delete(h_mass2);
    end
    grid on;
    
    axis equal;
    axis(0.4*[-1 1 -2 1 -2 2])
    xlabel('-x [m]')
    ylabel('-z [m]')
    zlabel('-y [m]')
    
    h_link0 = plot3(-link0(1,:),-link0(3,:),-link0(2,:),'k','LineWidth',2);
    h_link1 = plot3(-link1(1,:),-link1(3,:),-link1(2,:),'r','LineWidth',2);
    h_link2 = plot3(-link2(1,:),-link2(3,:),-link2(2,:),'b','LineWidth',2);
    h_mass1 = plot3(-p_c1(1),-p_c1(3),-p_c1(2),'ro','LineWidth',3);
    h_mass2 = plot3(-p_c2(1),-p_c2(3),-p_c2(2),'bo','LineWidth',3);
    
    
    subplot(2,3,2);
    grid on;
    hold on;
    plot([t(i) t(i+step)],[x(i,1) x(i+step,1)],'k--');
    xlabel('t [s]')
    ylabel('q_1 [rad]')
    axis([0 10 -max(abs(min(x(:,1))),max(x(:,1))) max(abs(min(x(:,1))),max(x(:,1)))])
    subplot(2,3,5);
    grid on;
    hold on;
    plot([t(i) t(i+step)],[x(i,2) x(i+step,2)],'k--');
    xlabel('t [s]');
    ylabel('q_2 [rad]');
    axis([0 10 -max(abs(min(x(:,2))),max(x(:,2))) max(abs(min(x(:,2))),max(x(:,2)))])
    
    subplot(2,3,3);
    grid on;
    hold on;
    plot([t(i) t(i+step)],[x(i,3) x(i+step,3)],'k--');
    xlabel('t [s]');
    ylabel('qd_1 [rad/s]');
    axis([0 10 -max(abs(min(x(:,3))),max(x(:,3))) max(abs(min(x(:,3))),max(x(:,3)))])
    
    subplot(2,3,6);
    grid on;
    hold on;
    plot([t(i) t(i+step)],[x(i,4) x(i+step,4)],'k--');
    xlabel('t [s]');
    ylabel('qd_2 [rad/s]');
    axis([0 10 -max(abs(min(x(:,4))),max(x(:,4))) max(abs(min(x(:,4))),max(x(:,4)))])
    
    pause(t(i+step)-t(i))
end


