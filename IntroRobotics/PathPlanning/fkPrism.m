function Prism_G = fkPrism(q,DH_table,type,Prism_L)
    % Desicription
    % q:= configuration of robot [1xD]
    % DH_table:= DH parameter of robot [Dx4]
    % type:= type of each joint [1xD]
    % Prism_L:= Prism of robot with respect to local coordinate frame [3x8xD]
    % Prism_G:= Prism of robot with respect to base coordinate frame [3x8xD]
    n = size(DH_table,1);
    H = zeros(4,4,n);
     %% Forward Kinematics
    %{
     for i = 1:n
        if type(i) == 0
            A_i = DHtrans(DH_table(i,1),DH_table(i,2)+q(i),DH_table(i,3),DH_table(i,4));
        elseif type(i) == 1
            A_i = DHtrans(DH_table(i,1)+q(i),DH_table(i,2),DH_table(i,3),DH_table(i,4));
        end

        if i > 1
            H(:,:,i) = H(:,:,i-1)*A_i;
        else
            H(:,:,i) = A_i;
        end
    end
    
    %% Forward Kinematics Prism
    for i = 1:n
        Prism_G(:,:,i) = [eye(3) zeros(3,1)]*(H(:,:,i)*[Prism_L(:,:,i);ones(1,size(Prism_L,2))]);
    end
    %}
    l1 = 250.5;
    l2 = 500;
    l3 = 100;
    l4 = 507.2;
    l5 = 0;
    l6 = 230;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    q5 = q(5);
    q6 = q(6);
    
    T1 = [ cos(q1 - pi/2), 0,  sin(q1 - pi/2),  0;
           sin(q1 - pi/2), 0, -cos(q1 - pi/2),  0;
                        0, 1,               0, l1;
                        0, 0,               0,  1];
    T2 = [ cos(q1 - pi/2)*cos(q2 + pi/2), -cos(q1 - pi/2)*sin(q2 + pi/2),  sin(q1 - pi/2), l2*cos(q1 - pi/2)*cos(q2 + pi/2);
           cos(q2 + pi/2)*sin(q1 - pi/2), -sin(q1 - pi/2)*sin(q2 + pi/2), -cos(q1 - pi/2), l2*cos(q2 + pi/2)*sin(q1 - pi/2);
                          sin(q2 + pi/2),                 cos(q2 + pi/2),               0,           l1 + l2*sin(q2 + pi/2);
                                       0,                              0,               0,                                1];
    T3 = [ cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3), -sin(q1 - pi/2), - cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) - cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2), l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
           cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3),  cos(q1 - pi/2), - cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) - cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2), l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                         cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2),               0,                                 cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3),                                         l1 + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                     0,               0,                                                                                             0,                                                                                                                                    1];
    T4 = [ cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)) - sin(q4)*sin(q1 - pi/2), - cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) - cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2), cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
           cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), - cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) - cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2), sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*cos(q1 - pi/2), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                  cos(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                 cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3),                                                        sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                       l1 - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                        0,                                                                                             0,                                                                                                                              0,                                                                                                                                                                                                                                       1];
    T5 = [ - cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)), - cos(q4)*sin(q1 - pi/2) - sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)),   sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
             cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)),   cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)), - sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                    sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                         -sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                          cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                       l1 - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                                                                                                                                                          0,                                                                                                                                0,                                                                                                                                                                                                                                                                0,                                                                                                                                                                                                                                       1];
    T6 = [ - cos(q6)*(cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) - sin(q6)*(cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))),   cos(q6)*(cos(q4)*sin(q1 - pi/2) + sin(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - sin(q6)*(cos(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + sin(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))), cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))), l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - l6*(sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
             sin(q6)*(cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)))), - sin(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3)))) - cos(q6)*(cos(q4)*cos(q1 - pi/2) - sin(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))), sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)), l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l6*(sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2))) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                                                                             cos(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - sin(q4)*sin(q6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                                                                                   sin(q6)*(sin(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + cos(q4)*cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) + cos(q6)*sin(q4)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)),                                                                                        cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2)) - cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)),                                                                                                                                                              l1 - l6*(cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2);
                                                                                                                                                                                                                                                                                                                                                                                                                               0,                                                                                                                                                                                                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                              0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1];
                                                                                                                                                                                                                                                                   
    Prism_G(:,:,1) = [eye(3) zeros(3,1)]*(T1*[Prism_L(:,:,1);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,2) = [eye(3) zeros(3,1)]*(T2*[Prism_L(:,:,2);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,3) = [eye(3) zeros(3,1)]*(T3*[Prism_L(:,:,3);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,4) = [eye(3) zeros(3,1)]*(T4*[Prism_L(:,:,4);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,5) = [eye(3) zeros(3,1)]*(T4*[Prism_L(:,:,5);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,6) = [eye(3) zeros(3,1)]*(T4*[Prism_L(:,:,6);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,7) = [eye(3) zeros(3,1)]*(T5*[Prism_L(:,:,7);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,8) = [eye(3) zeros(3,1)]*(T5*[Prism_L(:,:,8);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,9) = [eye(3) zeros(3,1)]*(T6*[Prism_L(:,:,9);ones(1,size(Prism_L,2))]);    
    Prism_G(:,:,10) = [eye(3) zeros(3,1)]*(T6*[Prism_L(:,:,10);ones(1,size(Prism_L,2))]);
    Prism_G(:,:,11) = [eye(3) zeros(3,1)]*(T6*[Prism_L(:,:,11);ones(1,size(Prism_L,2))]);
end

%% Helping function

function T = DHtrans(par1,par2,par3,par4)
    T = (rot('z',par1));
    T = T*(trans('z',par2));
    T = T*(trans('x',par3));
    T = T*(rot('x',par4));
end

function H = rot(axis, angle)
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
