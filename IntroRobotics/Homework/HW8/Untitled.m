%syms T qi qf vi vf
%a = [1 0 0 0 ; 0 1 0 0 ; 1 T T^2 T^3 ; 0 1 2*T 3*T^2];
%c = a\[qi;vi;qf;vf];
%q = sym('q',[5,1]);
%T = sym('T',[4,1]);
%syms v_1 v_N
%[v,c] = computeViaPointVel([2 2 2 2],[1 2 3 4 5 ; 10 4 3 2 1],[0;0],[0;0]);

q = [1 2 4 2 6 3 4 7 4 2; 
          1 5 2 3 5 6 4 7 8 6;
          5 2 4 5 6 4 5 4 3 2;
          2 5 4 1 5 2 1 6 3 4;
          5 6 3 5 4 6 2 3 4 5;
          2 3 4 5 6 2 1 4 5 6];
v_1 = [0 0 0 0 0 0]';
v_N = [0 0 0 0 0 0]';
v_max = [5 4 3 6 5 3]';
a_max = [4 3 2 3 3 2]';
[T,c] = FullcubicSpline(q,v_1,v_N,v_max,a_max);