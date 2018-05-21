function visualize(q_rand,q_near,q_new,q_ok,q_init,q_goal,q_lim,T)
    N = size(q_new,1); % number of configuration
    D = size(q_new,2); % dimension of configuration
    
    plot(q_init(1),q_init(2),'bo','linewidth',3);
    hold on
    for i = 1:numel(T.Node)
        x = T.Node{i};
        plot(x(1),x(2),'k.');
        if i > 1
            parent_x = T.Node{T.getparent(i)};
            plot([x(1) parent_x(1)],[x(2) parent_x(2)],'g--','linewidth',1);
        end
    end
    plot(q_goal(1),q_goal(2),'ro','linewidth',3);
    Rand = plot(q_rand(:,1),q_rand(:,2),'ko');
    Near = plot(q_near(:,1),q_near(:,2),'ro');
    New = plot(q_new(:,1),q_new(:,2),'b*');
    axis equal
    axis([q_lim(1,1) q_lim(1,2) q_lim(2,1) q_lim(2,2)]);
    pause(0.1);
    delete(Rand);
    delete(Near);
    delete(New);
end