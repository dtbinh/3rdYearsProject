function [x,y] = FK2dof(q1,q2,Pos)
    x = cos(q1)+cos(q1+q2) + Pos(1);
    y = sin(q1)+sin(q1+q2) + Pos(2);
end
