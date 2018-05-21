DH = [-pi/2 250.5 0 pi/2;
       pi/2 0 500 0;
       -1.0472 0 100 -1.5708;
       0 -507.2 0 1.5708;
       -0.5236 0 0 -1.5708;
       0 -230 0 3.14];
type = [1 1 1 1 1 1];
Prism = [200 200 -200 -200 200 200 200 -200 -200 200 200 200 -200 -200 -200 -200;
         30 30 30 30 30 -156.5 -156.5 -156.5 -156.5 -156.5 -156.5 30 30 -156.5 -156.5 30 ;
         265.3 -200 -200 265.3 265.3 265.3 -200 -200 265.3 265.3 -200 -200 -200 -200 265.3 265.3];
Prism(:,:,2) = [50 50 -570 -570 50 50 50 -570 -570 50 50 50 -570 -570 -570 -570;
                51.5 51.5 51.5 51.5 51.5 -126 -126 -126 -126 -126 -126 51.5 51.5 -126 -126 51.5 ;
                88.5 -96 -96 88.5 88.5 88.5 -96 -96 88.5 88.5 -96 -96 -96 -96 88.5 88.5];
Prism(:,:,3) = [62 62 -150 -150 62 62 62 -150 -150 62 62 62 -150 -150 -150 -150;
                46.5 46.5 46.5 46.5 46.5 -46.5 -46.5 -46.5 -46.5 -46.5 -46.5 46.5 46.5 -46.5 -46.5 46.5;
                174 -127 -127 174 174 174 -127 -127 174 174 -127 -127 -127 -127 174 174 ];
Prism(:,:,4) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                404 404 404 404 404 -50 -50 -50 -50 -50 -50 404 404 -50 -50 404;
                97 -112 -112 97 97 97 -112 -112 97 97 -112 -112 -112 -112 97 97];
Prism(:,:,5) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                95.1 95.1 95.1 95.1 95.1 -42 -42 -42 -42 -42 -42 95.1 95.1 -42 -42 95.1;
                35 -145 -145 35 35 35 -145 -145 35 35 -145 -145 -145 -145 35 35];
Prism(:,:,6) = [40 40 -40 -40 40 40 40 -40 -40 40 40 40 -40 -40 -40 -40;
                40 40 40 40 40 -40 -40 -40 -40 -40 -40 40 40 -40 -40 40;
                0 -105 -105 0 0 0 -105 -105 0 0 -105 -105 -105 -105 0 0];
Colis = [-500 800 ; -500 500 ; 0 1000];
q_lim = [-0.7854 3.927 ; -1.047 0.7854 ; 0 1.833 ;
         -3.143 3.143 ; -1.222 2.269 ; -3.143 3.143];
p_s = [200; 300 ;0];
o_s = [pi;0;0];
p_f = [-200; -450 ;500 ];
o_f = [pi/2;0;0];

[q_init, status1] = inverseKinematics(DH,p_s,o_s,q_lim);
[q_goal, status2] = inverseKinematics(DH,p_f,o_f,q_lim);
%q_init = [3.14 0.766 0.065 -3.14 0.309 1.571];
%q_goal = [0.938 -0.203 0.037 2.173 -0.839 -1.278];

v_1 = [0;0;0;0;0];
v_N = [0;0;0;0;0];
v_max = [0.2;0.2;0.2;0.2;0.2];
a_max = [0.5;0.5;0.5;0.5;0.5];
tic
[tree,Path] = buildRRT(DH,type,Prism,Colis,q_init(:,3)',q_goal(:,3)',q_lim,100,50,70,0.5);
toc
AnimateBot(Path)

%[T,c] = FullcubicSpline(Path,v_1,v_N,v_max,a_max);