tic;
[planning,robot,env] = motionPlanningExample;
toc;

%%
tic;
q = planning.path.reduced_path;
V = 1; % [rad/s]
A = 1; % [rad/s^2]
delta_q = q(:,2:end)-q(:,1:end-1);

dt = sqrt(sum(delta_q.^2))/V;
%
% average_qd = delta_q./dt;
% qd = zeros(size(q));
%
% for i = 1:size(average_qd,2)-1
%
% qd(:,i+1) = (average_qd(:,i).*average_qd(:,i+1)>0).*(average_qd(:,i)+average_qd(:,i+1))/2;
%
% end
%
% delta_qd = qd(:,2:end)-qd(:,1:end-1);
%
% average_qdd = delta_qd./dt;
% qdd = zeros(size(q));
%
% for i = 1:size(average_qdd,2)-1
%
% qdd(:,i+1) = (average_qdd(:,i).*average_qdd(:,i+1)>0).*(average_qdd(:,i)+average_qdd(:,i+1))/2;
%
% end

% zero intermediate velocity

qd = zeros(size(q));
qdd = zeros(size(q));

traj = trajGen(q,qd,qdd,dt);
toc;
% t = 0:0.01:traj.totalTime;
%
%
% axis equal;
% grid on;
%
% plot3(q(1,:),q(2,:),4*ones(size(t)),'g','linewidth',2)
%

tic;
w_n = 10;
K_P = diag([w_n^2 w_n^2]);
K_D = diag([2*w_n 2*w_n]);
u = @(t,x)invdynController(t,x,traj,K_P,K_D);
[t,x] = ode45(@(t,x)dynamics2DOF(t,x,u(t,x)),[0 traj.totalTime],[q(:,1);zeros(2,1)]);
toc;
q = x(:,1:2)';
qd = x(:,3:4)';
[q_r,qd_r,qdd_r,t,flag] = trajEval(traj,t);
%%
figure(1);clf;
subplot(2,4,[1 5]);
hold on;
axis equal;
grid on;
axis([min(env.workspace(1,:)) max(env.workspace(1,:)) min(env.workspace(2,:)) max(env.workspace(2,:))]);
for i = 1:numel(env.obstacles)
    plotPoly(env.obstacles{i},'k');
end

% Visualize Configuration space
subplot(2,4,[2 3 6 7]);
hold on;
axis equal

Q_1 = planning.mesh(:,:,1);
Q_2 = planning.mesh(:,:,2);
axis([Q_1(1,1) Q_1(end,1) Q_2(1,1) Q_2(1,end)])
plot(Q_1,Q_2,'k');
plot(Q_1',Q_2','k');
q_limit = robot.limits;
plotPoly([q_limit(1,1) q_limit(2,1) q_limit(2,1) q_limit(1,1) ;
    q_limit(2,2) q_limit(2,2) q_limit(1,2) q_limit(1,2)] ,'g');
surface(Q_1,Q_2,~planning.occ_grid/2)
h=linspace(0.5,1,64);
h=[h',h',h'];
set(gcf,'Colormap',h);


% visualize cell-path
grid_size = size(Q_1);
for i = 1:size(planning.path.cell_path,2)
    idx_1 = planning.path.cell_path(1,i);
    idx_2 = planning.path.cell_path(2,i);
    if (idx_1<=grid_size(1))&&(idx_2<=grid_size(2))
        surface(Q_1(idx_1:idx_1+1,idx_2:idx_2+1),Q_2(idx_1:idx_1+1,idx_2:idx_2+1),1*ones(2));
    end
end
plot3(planning.start.value(1),planning.start.value(2),1,'*r')
plot3(planning.goal.value(1),planning.goal.value(2),1,'*g')
xlabel('q_1')
ylabel('q_2')


set(gcf, 'Position', [100, 100, 1800, 800])

subplot(2,4,[1 5]) % workspace
    hold on;
    xlabel('x [m]')
ylabel('y [m]')
subplot(2,4,[2 3 6 7]) % configuration space
    hold on;    
subplot(2,4,[4]); % q1
grid on;
axis([min(t) max(t) min(q(1,:))-0.1*(max(q(1,:))-min(q(1,:))) max(q(1,:))+0.1*(max(q(1,:))-min(q(1,:)))]);
hold on;
xlabel('t [s]')
ylabel('q_1 [rad]')

subplot(2,4,[8]); % q1
grid on;
axis([min(t) max(t) min(q(2,:))-0.1*(max(q(2,:))-min(q(2,:))) max(q(2,:))+0.1*(max(q(2,:))-min(q(2,:)))]);
hold on;
xlabel('t [s]')
ylabel('q_2 [rad]')

step = 2;

for i = 1:step:numel(t)-step
    
    subplot(2,4,[1 5]) % workspace
    links = robot.space(q(:,i));
    h1 = plotPoly(links{1},'b');
    h2 = plotPoly(links{2},'b');
    subplot(2,4,[2 3 6 7]) % configuration space
    plot3(q(1,i:i+step),q(2,i:i+step),4*ones(size(q(1,i:i+step))),'b','linewidth',2)
    subplot(2,4,[4]); % q1
    plot(t(i:i+step),q(1,i:i+step),'b')
    plot(t(i:i+step),q_r(1,i:i+step),'k--')
    subplot(2,4,[8]); % q2
    plot(t(i:i+step),q(2,i:i+step),'b')
    plot(t(i:i+step),q_r(2,i:i+step),'k--')
    
    pause(t(i+step)-t(i))
    if i<numel(t)-step
        delete(h1)
        delete(h2)
    end
end


