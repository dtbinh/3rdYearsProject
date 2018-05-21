%Sorawit Inprom
%28/01/2018
%This function use to calculate pure translation homogeneous matrix in any
%axis
function H = trans(axis, dist)
    if axis == 'x'
        H = [1 0 0 dist ; 0 1 0 0 ; 0 0 1 0 ; 0 0 0 1];
    elseif axis == 'y'
        H = [1 0 0 0 ; 0 1 0 dist ; 0 0 1 0 ; 0 0 0 1];
    elseif axis == 'z'
        H = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 dist ; 0 0 0 1];    
    else
        H = 'error';
    end
end