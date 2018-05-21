function q_new = New_Conf(q_near,q_rand,l)
    %q_near:= all nearest configuration [NxD]
    %q_rand:= all random configuration [NxD]
    %l:= maximum distance between node
    %q_new:= new configration that apply maximum distance [NxD}
    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    for i = 1:N
        if norm(q_rand(i,:)-q_near(i,:)) < l
            q_new(i,:) = q_rand(i,:);
        else
            q_new(i,:) = q_near(i,:) + l*(q_rand(i,:)-q_near(i,:))/norm(q_rand(i,:)-q_near(i,:));
        end
    end
end
