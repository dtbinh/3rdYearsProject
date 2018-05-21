function [T,Path] = buildRRT(DH_table,type,Prism,Colis,q_init,q_goal,q_lim,k,n,greedy,l)
    %q_init:= initial configuration := 1xD matrix
    %q_goal:= goal configuration := 1xD matrix
    %q_limit:= limit of configuration := Dx2 matrix
    %k:= maximum step
    %n:= number of random configuration
    %greedy:= percentage of greedness [0,100]
    %l = maximum distance between node
    
    T = tree(q_init);
    %% Build Tree
    for i = 1:k
        q_rand = Rand_Conf(T,q_goal,q_lim,n,i,k,greedy);
        [q_near,near_node] = Nearest_Node(q_rand,T);
        q_new = New_Conf(q_near,q_rand,l);
        [q_ok,status] = Colis_Detec(q_new,DH_table,type,Prism,Colis);
        T = Add_New_Conf(q_new,status,near_node,T); 
    end
    
    iterater = T.breadthfirstiterator;
    for i = iterater
        node = i;
        if T.Node{node} == q_goal
            break;
        end
    end
    
    if T.Node{node} == q_goal
        index = 1;
        for i = T.findpath(1,node);
            Path(index,:) = T.Node{i};
            index = index+1;
        end
        Path = Path.';
    else
        Path = NaN;
    end
    
    
end

