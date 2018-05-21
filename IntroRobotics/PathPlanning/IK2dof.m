function q = IK2dof(x,y,Pos)
    c2 = ((x-Pos(1))^2 + (y-Pos(2))^2-2)/2;
    s2 = [sqrt(1-c2^2), -sqrt(1-c2^2)];

    q2 = [atan2(s2(1),c2), atan2(s2(2),c2)];
    
    A = [[-sin(q2(1)) 1+cos(q2(1)) ; 1+cos(q2(1)) sin(q2(1))]\[x-Pos(1) ; y-Pos(2)], [-sin(q2(2)) 1+cos(q2(2)) ; 1+cos(q2(2)) sin(q2(2))]\[x-Pos(1) ; y-Pos(2)]];
    q1 = [atan2(A(1,1),A(2,1)), atan2(A(1,2),A(2,2))];
    q = [q1(1) q2(1);q1(2) q2(2)];
end