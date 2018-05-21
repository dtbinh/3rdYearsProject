syms q1 l1 l2 q2 h
rot_z_q1 = [cos(q1) -sin(q1) 0 0 ; sin(q1) cos(q1) 0 0 ; 0 0 1 0 ; 0 0 0 1];
trans_z_0 = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1];
trans_x_l1 = [1 0 0 l1 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1];
rot_x_1 = rot('x',-pi/2);
T_1_0 = rot_z_q1*trans_x_l1*floor(rot_x_1);

trans_z_h = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 h; 0 0 0 1];
trans_x_q2l2 = [1 0 0 q2+l2 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1];
rot_x_2 = floor(rot('x',pi/2));
T_2_1 = trans_z_h*trans_x_q2l2*rot_x_2;

T_1_0*T_2_1
