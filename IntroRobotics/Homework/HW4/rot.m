%Sorawit Inprom
%28/01/2018
%This function use to calculate pure rotation homogeneous matrix in any
%axis
function H = rot(axis, angle)
    %angle = deg2rad(angle);
    if axis == 'x'
        H = [1 0 0 0 ; 0 cos(angle) -sin(angle) 0 ; 0 sin(angle) cos(angle) 0 ; 0 0 0 1];
    elseif axis == 'y'
        H = [cos(angle) 0 sin(angle) 0 ; 0 1 0 0 ; -sin(angle) 0 cos(angle) 0 ; 0 0 0 1];
    elseif axis == 'z'
        H = [cos(angle) -sin(angle) 0 0 ; sin(angle) cos(angle) 0 0 ; 0 0 1 0 ; 0 0 0 1];    
    else
        H = 'error';
    end

end