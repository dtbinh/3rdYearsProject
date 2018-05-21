function [T,Path] = RRT(q_init,q_goal,q_lim,k,l)
    %q_init = initial configuration := 1xD matrix
    %q_goal = goal configuration := 1xD matrix
    %q_limit = limit of configuration := Dx2 matrix
    %k = maximum step
    %l = maximum distance between node
    T = tree(q_init);
    %% Build Tree
    for i = 1:k
        q_rand = Rand_Conf(T,q_goal,q_lim,i);
        [q_near,near_node] = Nearest_Node(q_rand,T);
        q_new = New_Conf(q_near,q_rand,l);
        T = Add_New_Conf(q_new,near_node,T); 
        visualize(q_rand,q_near,q_new,q_init,q_goal,q_lim,T);
    end
    %% A* search
    node = 1;
    expored(1,1) = 1;
    while T.Node{node} ~= q_goal
        if ~T.isleaf(node)
            child = T.getchildren(node);
        else
            old_node = node;
            node = T.getparent(node);
            child = T.getchildren(T.getparent(node));
            T = T.removenode(old_node);

        end
        first = true;
        for i = 1:numel(child)
            if ~any(child(i) == expored)
                if first
                    min_dist = evaluation(T,node,child(i),q_goal);
                    next_node = child(i);
                    first = ~first;
                else
                    if evaluation(T,node,child(i),q_goal) < min_dist
                        min_dist = evaluation(T,node,child(i),q_goal);
                        next_node = child(i);
                    end
                end
                
            end
        end
        node = next_node;
        expored(1,numel(expored)+1) = node;
        x = T.Node{node};
        plot(x(1),x(2),'ro','LineWidth',2);
    end
    % generate path
    if T.Node{node} == q_goal
        index = 1;
        for i = T.findpath(1,node);
            Path(index,:) = T.Node{i};
            index = index+1;
        end
    else
        Path = NaN;
    end
    
    for i = 1:numel(Path)-1
        plot(Path(:,1),Path(:,2),'r','LineWidth',2);
    end
end

function y = evaluation(T,n_curr,n_next,q_goal)
    y = norm(T.Node{n_curr}-T.Node{n_next}) + norm(T.Node{n_next}-q_goal);
end