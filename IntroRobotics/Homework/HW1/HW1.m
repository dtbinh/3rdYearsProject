%Sorrawit Inprom 
%23/01/2018
%This function use for calculate the orientation with acted by ZYZ,
%(row,pitch,yaw),3x3rotationmatrix and find the state of airplane 
function [x,y,z,state] = HW1(act,key)
    if(key == 'rot')
        Frame_A = act;
        x = Frame_A(:,1);
        y = Frame_A(:,2);
        z = Frame_A(:,3);
        
    elseif(key == 'rpy')
        alpha = act(1);
        beta = act(2);
        gramma = act(3);

        R_roll = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha) ];
        R_pitch = [ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
        R_yaw = [ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
        Frame_A = R_yaw*R_pitch*R_roll;
        x = Frame_A(:,1);
        y = Frame_A(:,2);
        z = Frame_A(:,3);
        
    elseif(key == 'ZYZ')
        alpha = act(1);
        beta = act(2);
        gramma = act(3);
        
        Frame_A = [ cos(alpha) -sin(alpha) 0 ; sin(alpha) cos(alpha) 0 ; 0 0 1 ];
        Frame_A = Frame_A*[ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
        Frame_A = Frame_A*[ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
        x = Frame_A(:,1);
        y = Frame_A(:,2);
        z = Frame_A(:,3);  
        
    end
    
    state = Check(z);
    
end

function string = Check(Pos)
    if(Pos(3) <= -1/tan(deg2rad(10))*sqrt(Pos(1)^2+Pos(2)^2))
        string = 'yes';
    else
        string = 'no';
    end

end

