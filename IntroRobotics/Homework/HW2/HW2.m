%Sorawit Inprom
%28/01/2018
%This function use to find the homogenous transformation matrix about 2DOF
%manipulator at end-effector coordinate relate to Global coordinate 

function [Rot,Pos,state] = HW2(config)
    a = 1;
    b = 1.25;
    l = 3;
    w = 2.5;
    h = 0.5;
      
    H_B_0 = trans('x',l/2)*trans('y',w/2)*trans('z',h);
    H_1_B = rot('z',config(1))*trans('x',a);
    H_2_1 = rot('z',config(2))*trans('x',b);
    H_2_0 = H_B_0*H_1_B*H_2_1;
    
    Homo = H_2_0;
    Rot = Homo(1:3,1:3);
    Pos = Homo(1:3,4);
    
    if (Pos(1) > 0 && Pos(1) < l) && (Pos(2) > 0 && Pos(2) < w)
        state = 'Yes';
    else 
        state = 'No';
    end
    
end
    
