function pltRoad(o)
    x = linspace(0,800,50);
    y = x;
    y1 = x + 60;
    y2 = x - 60;
    for i = 1:size(x,2)-1
        hold on
        plot([x(i) x(i+1)],[y1(i) y1(i+1)],'k','linewidth',1);
        plot([x(i) x(i+1)],[y(i) y(i+1)],'--k','linewidth',1);
        plot([x(i) x(i+1)],[y2(i) y2(i+1)],'k','linewidth',1);
    end
    obstacle(o(1,:),o(2,:));
    axis equal
    axis([0 800 -40 840]);
end

function obstacle(o1,o2)
    obs = [-10 10 10 -10 -10 ; 10 10 -10 -10 10];
    rot = [cos(pi/4) -sin(pi/4) ; sin(pi/4) cos(pi/4)];
    
    Pos_obs1 = rot*obs + [o1(1)*100 ; o1(2)*100];
    Pos_obs2 = rot*obs + [o2(1)*100 ; o2(2)*100];
    
    plot(Pos_obs1(1,:),Pos_obs1(2,:),'r','linewidth',1);
    plot(Pos_obs2(1,:),Pos_obs2(2,:),'r','linewidth',1);

end