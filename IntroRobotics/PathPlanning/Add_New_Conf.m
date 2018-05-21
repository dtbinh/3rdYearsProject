function T = Add_New_Conf(q_new,status,near_node,T)
    % q_new:= new configuration [NxD]
    % status:= status in x,y,z of each configuration [N,3]
    % near_node:= nearest node in tree of each New configuration [Nx1]
    % T:= New Tree
 
    N = size(q_new,1); % number of configuration
    D = size(q_new,2); % dimension of configuration
    
    for i = 1:N
        if all(status(i,:) == 1)
            T = T.addnode(near_node(i,1),q_new(i,:));
        end
    end
    
end