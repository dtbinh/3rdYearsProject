DH = [0 0 1 0 ; 0 0 1 0];
type = [1;1];
q = sym('q',[2,1]);
fk = forwardKinematics(q,DH,type);
%[x,y] = FK2dof(1,1,[1,1]);
%[q1,q2] = IK2dof(x,y, [1,1]);

