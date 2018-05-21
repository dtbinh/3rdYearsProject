function R = RPY(act)

   alpha = act(1);
   beta = act(2);
   gramma = act(3);

   R_roll = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha) ];
   R_pitch = [ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
   R_yaw = [ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
   R = R_yaw*R_pitch*R_roll;
        
end

