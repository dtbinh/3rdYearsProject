Pos_init = [0,0];
q_init = [-1 0];
q_goal = IK2dof(0,1.7,Pos_init);
q_lim = [-pi pi; -pi pi];
DH = [0 0 1 0 ; 0 0 1 0];
type = [1 1];
Prism = [0 -1 -1 0 0 -1 -1 0 ; 0.1 0.1 -0.1 -0.1 0.1 0.1 -0.1 -0.1 ; 0 0 0 0 0 0 0 0]; 
Prism(:,:,2) = [0 -1 -1 0 0 -1 -1 0 ; 0.1 0.1 -0.1 -0.1 0.1 0.1 -0.1 -0.1 ; 0 0 0 0 0 0 0 0]; 
colis = [-1.5 1.5 ; -1.8,1.8 ; -1,1];
cc = [1.5 1.8; -1.5 1.8; -1.5 -1.8 ; 1.5 -1.8 ;1.5 1.8];
[~,Path] = RRT_new(DH,type,Prism,colis,q_init,q_goal(1,:),q_lim,20,100,50,0.);
pause(1);

mesh1 = [0 0.1 ; 1 0.1 ; 1 -0.1 ; 0 -0.1 ; 0 0.1]';
mesh2 = [0 0.1 ; 1 0.1 ; 1 -0.1 ; 0 -0.1 ; 0 0.1]';

for i = 1:size(Path,1)
   q1 = Path(i,1);
   q2 = Path(i,2);
   link1 = [cos(q1) -sin(q1) Pos_init(1) ; sin(q1) cos(q1) Pos_init(2) ; 0 0 1]*[mesh1;ones(1,5)];
   link2 = [cos(q1+q2) -sin(q1+q2) cos(q1)+Pos_init(1) ; sin(q1+q2) cos(q1+q2) sin(q1)+Pos_init(2)  ; 0 0 1]*[mesh1;ones(1,5)];
   plot(cc(:,1),cc(:,2),'b','linewidth',2);
   p1 = plot(link1(1,:),link1(2,:),'k','linewidth',1);
   hold on
   p2 = plot(link2(1,:),link2(2,:),'r','linewidth',1);
   axis equal
   axis([-2 2 -2 2]);
   pause(0.1);
   delete(p1);
   delete(p2);
    
end