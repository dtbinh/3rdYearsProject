function workspace
    hold on
    for i = 0:1000
        plot3([i i],[0 1000],[0 0],'m','linewidth',1);
        plot3([i i],[0 0],[0 1000],'c','linewidth',1);
        plot3([1000 1000],[i i],[0 1000],'y','linewidth',1);
        plot3([i i],[1000 1000],[0 1000],'c','linewidth',1);
    end
end