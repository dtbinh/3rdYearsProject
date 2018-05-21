function q_rand = Rand_Conf(T,q_goal,q_lim,n,i,k,greedy)
    %T:= tree
    %q_goal:= goal configuration [1xD]
    %q_lim:= limit of each dimension [Dx2]
    %n:= number of random configuration
    %i:= current iteration of processing
    %k:= maximum iteration
    %greedy:= percentage of greedness
    %q_rand:= random configuration [nxD]
    N = numel(T.Node); %number of node
    D = size(q_goal,2); %dimension of configuration
    
    for j = 1:D
        q_rand(:,j) = (q_lim(j,2)-q_lim(j,1)).*rand(n,1)+q_lim(j,1);
    end
    if mod(i,floor(k/floor(k*greedy/100))) == 0
        q_rand(n,:) = q_goal;
    end

end