function Path = sim2DRRT
%% Sim param
    q_init = [2 1];
    q_goal = [8 9];
    limit = [0 10 ; 0 10];
    
%% RRT Law
    Maximum_Eucl_distance = 1;
    Maximum_Iteration = 300;
    Number_Random_Config = 5;
    Percentage_Greedness = 10;
    
    RRTLaw.dl = Maximum_Eucl_distance;
    RRTLaw.k = Maximum_Iteration;
    RRTLaw.n = Number_Random_Config;
    RRTLaw.grd = Percentage_Greedness;

%% Build RRT
   [T,reach] = buildRRT(limit,q_init,q_goal,RRTLaw);
    if reach
        index = 1;
        iterater = T.breadthfirstiterator;
        for node = iterater
            if norm(T.Node{node}-q_goal) == 0
                for j = T.findpath(1,node)
                    Path(:,index) = T.Node{j}';                
                    if index > 1
                        pause(1)
                        plot([Path(1,index-1) Path(1,index)],[Path(2,index-1) Path(2,index)],'r','LineWidth',2);
                    end
                    index = index+1;
                end
                break;
            end
        end
        disp('Done!!!')
    else
        disp('Fail')
    end
    
end

%% Build RRT
function [T,reach] = buildRRT(limit,q_init,q_goal,Law)
    hold on
    axis equal
    axis([0 10 0 10])
    
    T = tree(q_init);
    
    plot(q_init(1),q_init(2),'ob','LineWidth',3)
    plot(q_goal(1),q_goal(2),'or','LineWidth',3)
    
    %% Build Tree
    for i = 1:Law.k
        q_rand = Rand_Conf(limit,q_goal,i,Law);
        [q_near,near_node] = Nearest_Node(q_rand,T);
        q_new = New_Conf(q_near,q_rand,Law.dl);
        T = Add_New_Conf(q_new,ones(numel(q_new),1),near_node,T); 
        reach = isReach(q_new,q_goal);
        
        plot_rand = plot(q_rand(:,1),q_rand(:,2),'*g','LineWidth',2);
        plot_near = plot(q_near(:,1),q_near(:,2),'*y','LineWidth',2);
        for j = 1:numel(q_near(:,1))
            circle(j) = plot(q_near(j,1)+ Law.dl*cos(0:0.1:2*pi),q_near(j,2)+ Law.dl*sin(0:0.1:2*pi),'--b');
        end      
        
        pause(1)
        delete(plot_rand)
        delete(plot_near)
        delete(circle)
        
        for j = 1:numel(q_new(:,1))
            plot([q_near(j,1) q_new(j,1)],[q_near(j,2) q_new(j,2)],'--g');
        end
        plot_new = plot(q_new(:,1),q_new(:,2),'*k','LineWidth',3);
        
        if reach, break; end
    end    

end

%% RRT function
function q_rand = Rand_Conf(q_lim,q_goal,i,Law)
    k = Law.k;
    n = Law.n;
    greedy = Law.grd;
  
    D = size(q_goal,2); %dimension of configuration
    
    for j = 1:D
        q_rand(:,j) = (q_lim(j,2)-q_lim(j,1)).*rand(n,1)+q_lim(j,1);
    end
    if mod(i,floor(k/floor(k*greedy/100))) == 0
        q_rand(n,:) = q_goal;
    end

end

function [q_near,near_node] = Nearest_Node(q_rand,T)
    
    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    q_near = zeros(N,D);
    near_node = zeros(N,1);
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

function q_new = New_Conf(q_near,q_rand,l)

    N = size(q_rand,1); % number of random configuration
    D = size(q_rand,2); % dimension of random configuration
    
    q_new = zeros(N,D);
    for i = 1:N
        if norm(q_rand(i,:)-q_near(i,:)) < l
            q_new(i,:) = q_rand(i,:);
        else
            q_new(i,:) = q_near(i,:) + l*(q_rand(i,:)-q_near(i,:))/norm(q_rand(i,:)-q_near(i,:));
        end
    end
end

function T = Add_New_Conf(q_new,status,near_node,T)
    N = size(q_new,1); % number of configuration
    
    for i = 1:N
        if status(i,1)
            T = T.addnode(near_node(i,1),q_new(i,:));
        end
    end
end

function reach = isReach(q_new,q_goal)
    N = size(q_new,1);
    reach = false;
    for i = 1:N
        if norm(q_new(i,:)-q_goal) == 0
            reach = true;
            break
        end
    end
end



