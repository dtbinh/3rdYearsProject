function [q_near,near_node] = Nearest_Node(q_rand,T)
    %q_rand:= interested configration (random configration) [NxD]
    %T:= Tree
    %q_near:= nearest configration of each inrested configuration [NxD]
    %near_node:= nearest node in tree of each inrested configuration [Nx1]
    
    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    for i = 1:N
        for k = 1:numel(T.Node)
            if k == 1 % assign minimum distance 
                q_near(i,:) = T.get(k);
                near_node(i,1) = k;
                min_dist = norm(q_rand(i,:)-T.get(k));
            else % search new minimum distance
               if  norm(q_rand(i,:)-T.get(k)) <= min_dist
                   q_near(i,:) = T.get(k);
                   near_node(i,1) = k;
                   min_dist = norm(q_rand(i,:)-T.get(k));
               end
            end
        end
    end
    
end