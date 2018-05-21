syms l1 h1 l2 l3 l4 h4 l0
pi = sym('pi');
q = sym('q',[4,1]);
%type = [1 1 0 1]';
type = [0 1 1 1]';
%q = [0 0 0 0 ]'; 
%l0 = 250;
%l1 = 100;
%l2 = 100;
%l3 = 100;
%l4 = 150;
%DH = [0 0 l2 0 ; 0 0 l3 pi ; 0 l4 0 0 ; 0 h4 0 0];
DH2 = [pi/2 l0 l1 0 ; 0 0 l2 0 ; 0 0 l3 -pi/2 ; 0 -l4 0 pi];
%q = [0 0 pi/6 pi/3]'; 
[H, H_e, R_e, p_e] = forwardKinematics(q,DH2,type);
%display(simplify(H_e));
%base = [1 0 0 l1 ; 0 1 0 0 ; 0 0 1 h1 ; 0 0 0 1];
%FKEqu = base*simplify(H_e);
%display(FKEqu);
H
%display(simplify(H_e))
