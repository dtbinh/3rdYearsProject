function [t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max)

D = size(q,1);
N = size(q,2);

t_i = cumsum([0;T(1:end-1)]);
t_v = [];
q_v = [];
qd_v = [];
qdd_v = [];
for i = 1:D
    subplot(3,D,D*(1-1)+i)
%    title('q' + string(i))
    hold on;
    plot([t_i;t_i(end)+T(end)],q(i,:),'ko','linewidth',2)
    grid on;

    subplot(3,D,D*(2-1)+i)
 %   title('qd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*v_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*v_max(i,:),'k--')
    grid on;

    subplot(3,D,D*(3-1)+i)
  %  title('qdd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*a_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*a_max(i,:),'k--')
    grid on;


    for k = 1:N-1
        t = t_i(k):0.01:(t_i(k)+T(k));
        tau = (t-t_i(k));
        q_t = c(:,k,i)'*[ones(size(tau));tau;tau.^2;tau.^3];
        qd_t = c(:,k,i)'*[zeros(size(tau));ones(size(tau));2*tau;3*tau.^2];
        qdd_t = c(:,k,i)'*[zeros(size(tau));zeros(size(tau));2*ones(size(tau));6*tau];
        subplot(3,D,D*(1-1)+i)
        plot(t,q_t)
        subplot(3,D,D*(2-1)+i)
        plot(t,qd_t)
        subplot(3,D,D*(3-1)+i)
        plot(t,qdd_t)

    end
end
end