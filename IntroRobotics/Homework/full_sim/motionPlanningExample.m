function [planning,robot,env] = motionPlanningExample

%% workspace
% total workspace's dimension
width = 3;
length = 4;
% vertices of workspace in 2D
workspace = [   -width/2    width/2     width/2     -width/2;
    -length/2   -length/2   length/2    length/2];
% plotPoly(workspace,'k');
env.workspace = workspace; 
%% obstacle

% vertices of obstacles in 2D
obstacle_1 = [  -1.5    -1      -1      -1.5;
    1       1       0.5     0.5 ];
obstacle_2 = [  0.5     1       1       0.5 ;
    -1      -1      -1.5    -1.5];
obstacles = {obstacle_1,obstacle_2};
env.obstacles = obstacles;

%% Robot's definition

% Robot Occupied space
A = @robotSpace;

q_limit = [-pi  -3*pi/4; % lower limit
    pi  3*pi/4]; % upper limit
robot.space = A;
robot.limits=  q_limit;

%% Configuration space
dq = 4*pi/180;
q_1 = linspace(q_limit(1,1),q_limit(2,1),round((q_limit(2,1)-q_limit(1,1))/dq));
dq = q_1(2)-q_1(1);
q_2 = q_limit(1,2):dq:q_limit(2,2);
[Q_1,Q_2] = meshgrid(q_1,q_2);
Q_1 = Q_1';
Q_2 = Q_2';

% Computing Configuration Free Space
Occupancy_grid = zeros(size(Q_1));
for i = 1:numel(q_1)
    for j = 1:numel(q_2)
        q = [Q_1(i,j)+dq/2;Q_2(i,j)+dq/2];
        intersect = 0;
        
        A_q = A(q);
        for k = 1:size(q_limit,2)
            A_k = A_q{k};
            link = A_k;
            x = 1;
            y = 2;
            intersect = intersect || ~all(inpolygon(link(x,:),link(y,:),workspace(x,:),workspace(y,:)));
            if intersect
                break;
            end
            for l = 1:numel(obstacles)
                obstacle_l = obstacles{l};
                intersect = intersect || isintersect(A_k, obstacle_l);
                if intersect
                    break;
                end
            end
        end
        
        Occupancy_grid(i,j) = intersect;
    end
end

%% Start & Goal location
x_s = -1.25; %%%%%%%%%%
y_s = 1.35;  %%%%%%%%%%
q_s = IK(x_s,y_s,1);

%{
[1.25 -1.125 0], [-0.75 -0.4 1]
%}
x_g = 1.25;   %%%%%%%%%
y_g = -1.125; %%%%%%%%%
q_g = IK(x_g,y_g,0);

%% search for path

% A-star search on configuration space
[idx1_s,idx2_s] = findNearest(q_s,Q_1,Q_2);
[idx1_g,idx2_g] = findNearest(q_g,Q_1,Q_2);
path = AStar(cat(3,Q_1,Q_2),Occupancy_grid,idx1_s,idx2_s,idx1_g,idx2_g);

%% reduce cell-path to seqence of line segments
start = q_s;
goal = q_g;
lineSegments = gridCells2LineSegments(start,goal,path,Q_1,Q_2,Occupancy_grid);
reduced_path = zeros(2,numel(lineSegments)+1);
cell_path = [];
cell_path(:,1) = [idx1_s;idx2_s];
for i = 1:numel(lineSegments)
    segment = lineSegments{i};
    reduced_path(:,i) = segment(:,1);
    
    current = segment(:,1);
    next = segment(:,2);
    pass = line2gridCells(current,next,Q_1,Q_2);
    cell_path = [cell_path pass(:,2:end)];
    
end
reduced_path(:,end) = segment(:,end);
%plot3(reduced_path(1,:),reduced_path(2,:),ones(size(reduced_path)),'b','linewidth',3)
planning.path.reduced_path = reduced_path;
planning.path.cell_path = cell_path;
planning.path.a_star_path = path;

planning.start.value = q_s;
planning.goal.value = q_g;
planning.start.idx = [idx1_s;idx2_s];
planning.goal.idx = [idx1_g;idx2_g];

planning.occ_grid = Occupancy_grid;
planning.mesh = cat(3,Q_1,Q_2);
planning.configuration_range = {q_1,q_2};
planning.increment = dq;


%{
%% Show result
q = [q_1(idx1_s);q_2(idx2_s)];
A_q = A(q);
figure(1)
plotPoly(A_q{1},'g');
plotPoly(A_q{2},'g');
q = [q_1(idx1_g);q_2(idx2_g)];
A_q = A(q);
figure(1)
plotPoly(A_q{1},'r');
plotPoly(A_q{2},'r');

for k = 1:size(cell_path,2)
    
    i = cell_path(1,k);
    j = cell_path(2,k);
    %     figure(2)
    %     plot3(q_1(i),q_2(j),1,'b*','linewidth',5)
    q = [q_1(i);q_2(j)];
    A_q = A(q);
    figure(1)
    h1 = plotPoly(A_q{1},'b');
    h2 = plotPoly(A_q{2},'b');
    pause(0.2)
    if k <= size(cell_path,2)
        delete(h1)
        delete(h2)
    end
end


%% Replot the start and goal location
figure(1)
q = [q_1(idx1_s);q_2(idx2_s)];
A_q = A(q);
plotPoly(A_q{1},'g');
plotPoly(A_q{2},'g');
q = [q_1(idx1_g);q_2(idx2_g)];
A_q = A(q);
plotPoly(A_q{1},'r');
plotPoly(A_q{2},'r');
%}


end
%%
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
function h = plotPoly(p,varargin)
p = [p p(:,1)];
if isempty(varargin)
    h = plot(p(1,:),p(2,:));
else
    h = plot(p(1,:),p(2,:),varargin{1});
end
end

function [A,links] = robotSpace(q)
l1 = 1;
l2 = 1;

w = 0.25;
link_1 = [-l1-w/2 w/2 w/2 -l1-w/2;
    w/2 w/2 -w/2 -w/2];

link_2 = [-l2-w/2 w/2 w/2 -l2-w/2;
    w/2 w/2 -w/2 -w/2];
links = {link_1,link_2};
%transform = @(T,p)T(1:2,1:2)*p+T(1:2,3);
FK_1 = [cos(q(1)) -sin(q(1))  l1*cos(q(1));
    sin(q(1)) cos(q(1))  l1*sin(q(1));
    0         0          1];
FK_2 = [cos(q(1)+q(2)) -sin(q(1)+q(2))  l1*cos(q(1))+l2*cos(q(1)+q(2));
    sin(q(1)+q(2)) cos(q(1)+q(2))  l1*sin(q(1))+l2*sin(q(1)+q(2));
    0         0          1];
A_1 = transform(FK_1,link_1);
A_2 = transform(FK_2,link_2);

A = {A_1,A_2};

end

function A = transform(T,p)
    A = T(1:2,1:2)*p;
    for i = 1:size(p,2)
        A(:,i) = A(:,i)+T(1:2,3);
    end
end
function q = IK(x,y,p)
l1 = 1;
l2 = 1;
c2 = (x^2+y^2-l1^2-l2^2)/(2*l1*l2);

s2 = (-1)^(p+1)*sqrt(1-c2^2);
q2_s = atan2(s2,c2);
q1_s = atan2(-x*l2*sin(q2_s)+y*(l1+cos(q2_s)),x*(l1+cos(q2_s))+y*l2*sin(q2_s));

q = [q1_s;q2_s];

end

function [idx1,idx2] = findNearest(q,Q_1,Q_2)
dq = Q_1(2,1)-Q_1(1,1);
[temp,idx1] = min((Q_1-q(1)+dq/2).^2+(Q_2-q(2)+dq/2).^2);
[~,idx2] = min(temp);
idx1 = idx1(idx2);
end

function adj = adjacency4 (oc)

[r,c] = size(oc);                        %# Get the matrix size
diagVec1 = repmat([ones(c-1,1); 0],r,1);  %# Make the first diagonal vector
%#   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);             %# Remove the last value
diagVec2 = ones(c*(r-1),1);               %# Make the second diagonal vector
%#   (for vertical connections)
adj = diag(diagVec1,1)+...                %# Add the diagonals to a zero matrix
    diag(diagVec2,c);
adj = adj+adj.';                         %'# Add the matrix to a transposed
%#   copy of itself to make it
%#   symmetric
for k = 1:r*c
    i = (k-1-mod(k-1,c))/c+1;
    j = mod(k-1,c)+1;
    if oc(i,j)
        adj(k,:) = 0;
        adj(:,k) = 0;
    end
end

end

function path = pathNode2pathGrid(total_path,oc)
path = zeros(ndims(oc),numel(total_path));
k = 1;
num_2 = size(oc,2);
for node = total_path
    i = (node-1-mod(node-1,num_2))/num_2+1;
    j = mod(node-1,num_2)+1;
    path(:,k) = [i;j];
    k = k+1;
end
end

function path = AStar(Q,oc,idx1_s,idx2_s,idx1_g,idx2_g)
adj = adjacency4(oc);
start_idx = (idx1_s-1)*size(oc,2)+idx2_s;
goal_idx = (idx1_g-1)*size(oc,2)+idx2_g;
num_node = size(oc,1)*size(oc,2);
open_set = start_idx;
closed_set = [];
gScore = inf(1,num_node);
fScore = inf(1,num_node);
gScore(start_idx) = 0;
fScore(start_idx) = 1;
cameFrom = zeros(1,num_node);
cameFrom(start_idx) = -1;
while ~isempty(open_set)
    [~,idx] = min(fScore(open_set));
    current = open_set(idx);
    if current == goal_idx
        total_path =current;
        while cameFrom(current)~=-1
            current = cameFrom(current);
            total_path = [current total_path];
        end
        path = pathNode2pathGrid(total_path,oc);
        return
    end
    idx_rem = find(open_set==current);
    open_set(idx_rem) = [];
    closed_set = [closed_set current];
    neighbor = find(adj(current,:));
    for idx = neighbor
        if ~ismember(idx,closed_set)
            open_set = [open_set idx];
        end
        num_2 = size(oc,2);
        i = (current-1-mod(current-1,num_2))/num_2+1;
        j = mod(current-1,num_2)+1;
        q_current = permute(Q(i,j,:),[3 2 1]);
        i = (idx-1-mod(idx-1,num_2))/num_2+1;
        j = mod(idx-1,num_2)+1;
        q_neighbor = permute(Q(i,j,:),[3 2 1]);
        e = q_neighbor-q_current;
        cost_to_go = e'*e; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tentative_gScore = gScore(current)+cost_to_go;
        if tentative_gScore >= gScore(idx)
            continue;
        end
        cameFrom(idx) = current;
        gScore(idx) = tentative_gScore;
        q_goal = permute(Q(idx1_g,idx2_g,:),[3 2 1]);
        
        e = q_neighbor-q_goal;
        heuristic = e'*e; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fScore(idx) = gScore(idx)+0.1*heuristic;
    end
    
end
error('cant find path')
end

function pass_through = line2gridCells(start,goal,Q_1,Q_2)
q_1_lower_limit = Q_1(1,1);
q_2_lower_limit = Q_2(1,1);
dq = Q_1(2,1)-Q_1(1,1);
idx_1_s = floor((start(1)-q_1_lower_limit)/dq)+1;
idx_2_s = floor((start(2)-q_2_lower_limit)/dq)+1;

idx_1_g = floor((goal(1)-q_1_lower_limit)/dq)+1;
idx_2_g = floor((goal(2)-q_2_lower_limit)/dq)+1;


e = goal-start;
full_len = sqrt(e'*e);
theta = atan2(e(2),e(1));

l = linspace(0,full_len,10);
line_q_1 = l*cos(theta)+start(1);
line_q_2 = l*sin(theta)+start(2);


% increment step
in_x = sign(cos(theta));
in_y = sign(sin(theta));

if in_x == 0
    in_x = 1;
end

if in_y == 0
    in_y = 1;
end

% search for path
current_idx_1 = idx_1_s;
current_idx_2 = idx_2_s;
current_x = start(1);
current_y = start(2);
pass_through = [current_idx_1;current_idx_2];
while (current_idx_1~=idx_1_g)||(current_idx_2~=idx_2_g)

x_v = dq*(current_idx_1+0.5*(in_x-1))+q_1_lower_limit;
y_v = dq*(current_idx_2+0.5*(in_y-1))+q_2_lower_limit;
corner = atan2(y_v-current_y,x_v-current_x);

current_idx_1 = current_idx_1 + (1+(-1)^(theta>=corner)*in_x*in_y)/2*in_x;
current_idx_2 = current_idx_2 + (1-(-1)^(theta>=corner)*in_x*in_y)/2*in_y;

y_int = tan(theta)*(x_v-current_x)+current_y;
x_int = cot(theta)*(y_v-current_y)+current_x;

current_x =  (1+(-1)^(theta>=corner)*in_x*in_y)/2*x_v + (1-(-1)^(theta>=corner)*in_x*in_y)/2*x_int;
current_y = (1-(-1)^(theta>=corner)*in_x*in_y)/2*y_v +  (1+(-1)^(theta>=corner)*in_x*in_y)/2*y_int;

pass_through = [pass_through [current_idx_1;current_idx_2]];
end

end
function [idx_1,idx_2,idx] = findBreakPoint(start,goal,list_idx,Q_1,Q_2)
dq = Q_1(2,1)-Q_1(1,1);
e = goal-start;
theta = atan2(e(2),e(1));
q_1 = Q_1(:,1)';
q_2 = Q_2(1,:);
x_i = q_1(list_idx(1,:))+dq/2;
y_i = q_2(list_idx(2,:))+dq/2;
x_in = ((y_i-start(2))+(cot(theta)*x_i+tan(theta)*start(1)))/(cot(theta)+tan(theta));
y_in = tan(theta)*(x_in-start(1))+start(2);
e = sqrt((x_in-x_i).^2+(y_in-y_i).^2);
[~,idx] = max(e);
idx_1 = list_idx(1,idx);
idx_2 = list_idx(2,idx);


end

function lineSegments = gridCells2LineSegments(start,goal,list_idx,Q_1,Q_2,varargin)

% start
% goal
% h1 = plot3([start(1) goal(1)],[start(2) goal(2)],[1 1],'b','linewidth',2)
pass_through = line2gridCells(start,goal,Q_1,Q_2);
q_1 = Q_1(:,1)';
q_2 = Q_2(1,:);
dq = q_1(2)-q_1(1);
% h = plot3(q_1(pass_through(1,:))+dq/2,q_2(pass_through(2,:))+dq/2,2*ones(size(pass_through(1,:))),'b*');
pass_idx = (pass_through(2,:)-1)*numel(q_1)+pass_through(1,:);
idx_list = (list_idx(2,:)-1)*numel(q_1)+list_idx(1,:);

if ~isempty(varargin)
    oc = varargin{:};
    isFree = true;
    for i = 1:size(pass_through,2)
        isFree = isFree && ~oc(pass_through(1,i),pass_through(2,i));
    end
    
    if isFree
        lineSegments = {[start goal]};
        return
    end
end

if all(ismember(pass_idx,idx_list))
    lineSegments = {[start goal]};
    return
else
    [idx_1,idx_2,idx] = findBreakPoint(start,goal,list_idx,Q_1,Q_2);
    break_point = [q_1(idx_1)+dq/2;q_2(idx_2)+dq/2];
    %     plot3(break_point(1),break_point(2),1,'mo')
    %     pause(2)
    %     delete(h)
    %     delete(h1)
    if ~isempty(varargin)
        firstHalf = gridCells2LineSegments(start,break_point,list_idx(:,1:idx),Q_1,Q_2,varargin{:});
        secondHalf = gridCells2LineSegments(break_point,goal,list_idx(:,idx:end),Q_1,Q_2,varargin{:});
    else
        firstHalf = gridCells2LineSegments(start,break_point,list_idx(:,1:idx),Q_1,Q_2);
        secondHalf = gridCells2LineSegments(break_point,goal,list_idx(:,idx:end),Q_1,Q_2);
    end
    
    
    lineSegments = [firstHalf,secondHalf];
end

end