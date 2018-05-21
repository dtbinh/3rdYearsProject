function [q_can, status] = palm(p_e,view)
    %% Input
    DH = [-pi/2,  250.5,    0,  pi/2;
                 pi/2,      0,  500,     0;
                -pi/3,      0,  100, -pi/2;
                    0, -507.2,    0,  pi/2;
                -pi/6,      0,    0, -pi/2;
                    0,   -230,    0,    pi];
                
    limits = [  -0.79    3.93;  %limit joint 1
                 -1.05    0.79;  %limit joint 2
                  -0.5    1.84;  %limit joint 3
                -1.571   1.571;  %limit joint 4
                -1.222   2.269;  %limit joint 5
                -1.571   1.571]; %limit joint 6
    if view == 'r'
       o_e = [pi/2;-pi/2;0];
    elseif view == 'l'
       o_e = [pi/2;-pi/2;pi];
    elseif view == 'b'
        o_e = [pi;0;0];
    end

    %% wrist Pose
    P_w = [RPY(o_e) p_e ; 0 0 0 1]*[1 0 0 0 ; 0 1 0 0 ; 0 0 1 DH(6,2) ; 0 0 0 1]*[0 0 0 1]';
    
    x = P_w(1);
    y = P_w(2);
    z = P_w(3);
    r = P_w'*P_w;

    %% define f1 f2 f3
    f1 = @(x)(DH(4,2)*sin(x)*sin(DH(3,4)) + DH(3,3)*cos(x));
    f2 = @(x)(-DH(4,2)*cos(x)*sin(DH(3,4)) + DH(3,3)*sin(x));
    f3 = @(x)(DH(4,2)*cos(DH(3,4)) + DH(3,2));
    
    %% define k1 k2 k3 k4 k5 k6  
    k1 = @(x)(2*DH(1,3)*(f1(x)+DH(2,3)));
    k1 = @(x)(k1(x) + 2*sin(DH(1,4))*DH(1,2)*(cos(DH(2,4))*f2(x) - sin(DH(2,4))*f3(x)));
    
    k2 = @(x)(2*sin(DH(1,4))*DH(1,2)*(f1(x)+DH(2,3)));
    k2 = @(x)(k2(x) + 2*DH(1,3)*(cos(DH(2,4))*f2(x) - sin(DH(2,4))*f3(x)));
     
    k5 = @(x)(f1(x)^2 + f2(x)^2 + f3(x)^2);
    k5 = @(x)(k5(x) + DH(1,3)^2 + DH(2,3)^2 + DH(1,2)^2 + DH(2,2)^2);
    k5 = @(x)(k5(x) + 2*DH(2,3)*f1(x) + 2*DH(2,2)*sin(DH(2,4))*f2(x) + 2*DH(2,2)*cos(DH(2,4))*f3(x));
    
    k6 = @(x)(cos(DH(1,4))*(sin(DH(2,4))*f2(x) + cos(DH(2,4))*f3(x) + DH(2,2)) + DH(1,2));
   
    %% find Theta3    
    a = (DH(4,2)/DH(3,3))^2 + 1;
    sq = (r - 2*DH(1,2)*(z-DH(1,2))-DH(1,2)^2-DH(2,3)^2-DH(4,2)^2-DH(3,3)^2)/(2*DH(2,3)*DH(3,3));
    b = 2*DH(4,2)/DH(3,3)*sq;
    c = sq^2 - 1;
    
    if b^2-4*a*c >= 0 %% solution found
     %%   
        T3_can = [];
        for i = 1:2
            s3 = Root(a,b,c,i);
            for j = 1:2
                c3 = Mom(s3,j);
                T3 = atan2(s3,c3);
                if verify_q3([0 0 T3])
                    T3_can(i,1) = T3;
                end
            end
        end 

        %% find Theta2
        a = @(x)((f1(x)+DH(2,3))^2 + f2(x)^2);
        b = @(x)(-2*(f1(x)+DH(2,3))*(z - k6(x)));
        c = @(x)((z-k6(x))^2 - f2(x)^2);

        T2_can =[];
        for i = 1:size(T3_can,1)
            T3 = T3_can(i);
            for j = 1:2
                s2 = Root(a(T3),b(T3),c(T3),j);
                for k = 1:2
                    c2 = Mom(s2,k);
                    T2 = atan2(s2,c2);
                    if verify_q2([0 T2 T3])
                       T2_can(i,j) = T2;
                    end
                end
            end
        end

        %% find Theta1
        A = @(x,y)((f1(y)+DH(2,3))*cos(x) - f2(y)*sin(x));

        T1_can = [];
        for i = 1:size(T2_can,1)
            for j = 1:size(T2_can,2)
                T2 = T2_can(i,j);
                T3 = T3_can(i);
                c1 = x/A(T2,T3);
                s1 = y/A(T2,T3);
                T1_can(i,j) = atan2(s1,c1);
            end
        end
        
        %% find Theta 4,5,6
        R_0e = RPY(o_e);

        T_all = zeros([6,8]);
        for i = 1:size(T2_can,1)
            for j = 1:size(T2_can,2)
                T1 = T1_can(i,j);
                T2 = T2_can(i,j);
                T3 = T3_can(i);

                R_03 = [ cos(T2+T3)*cos(T1) , -sin(T1) , -sin(T2+T3)*cos(T1) ;
                         cos(T2+T3)*sin(T1) ,  cos(T1) , -sin(T2+T3)*sin(T1) ;
                                  sin(T2+T3) ,         0 ,           cos(T2+T3) ];
                R_36 = R_03'*R_0e;
                for k = 1:2
                    s5 = (-1)^k*sqrt(R_36(3,1)^2 + R_36(3,2)^2);
                    c5 = -R_36(3,3);

                    T5 = atan2(s5,c5);
                    T6 = atan2(R_36(3,2)/s5, R_36(3,1)/s5);
                    T4 = atan2(R_36(2,3)/s5, R_36(1,3)/s5);

                    T_all(:,4*(i-1)+2*(j-1)+k) = [T1;T2;T3;T4;T5;T6];
                end
            end
        end
        
        for i = 1:size(T_all,2)
            q(:,i) = T_all(:,i) - [DH(1,1);DH(2,1);DH(3,1);DH(4,1);DH(5,1);DH(6,1)];
        end
                
        %% Check joint limit
        q_can = JointLimit(q,limits);
        if isnan(q_can)
            status = 2; %out of joint limit
            q = NaN;
        else
            status = 1; %solution found!
            simforwardKinematics(q_can,DH,[1;1;1;1;1;1]);
        end
    else 
        q = NaN;
        q_can = NaN;
        status = 0; %No solution!!
    end
    %% extend function
    function out = Mom(xx,n)
        out = (-1)^(n+1)*sqrt(1-xx^2);
    end

    function out = Root(a,b,c,n)
        out = (-b + ((-1)^(n+1))*sqrt(b^2-4*a*c))/(2*a);
    end

    function out = verify_q2(config)
        T = config;
        out = abs((r-k5(T(3))) - (k1(T(3))*cos(T(2)) + k2(T(3))*sin(T(2)))) < 1; 
    end  
    
    function out = verify_q3(config)
        T = config;
        out = abs((r-k5(T(3))) - (2*DH(1,2)*(z-k6(T(3))))) < 1 ;
    end
    
end

function R = RPY(act)

   alpha = act(1);
   beta = act(2);
   gramma = act(3);

   R_roll = [ 1 0 0 ; 0 cos(alpha) -sin(alpha) ; 0 sin(alpha) cos(alpha) ];
   R_pitch = [ cos(beta) 0 sin(beta) ; 0 1 0 ; -sin(beta) 0 cos(beta) ];
   R_yaw = [ cos(gramma) -sin(gramma) 0 ; sin(gramma) cos(gramma) 0 ; 0 0 1 ];
        
   R = R_yaw*R_pitch*R_roll;
        
end

function q_can = JointLimit(q,limit)
    status = [];
    q_can = [];
    for i = 1:size(q,2)
        if all((q(:,i) >= limit(:,1))) && all((q(:,i) <= limit(:,2)))
            status(1,i) = 1;
        else
            status(1,i) = 0;
        end
        
    end
    index = 1;
    for i = 1:size(q,2)
        if status(1,i) == 1
            q_can(:,index) = q(:,i);
            index = index + 1;
        end
    end
    if numel(q_can) == 0
        q_can = NaN;
    end
end

function [H, H_e, R_e, p_e,A] = simforwardKinematics(q,DH_table,type)

% H := [4 x 4 x n] matrix
% H_e := [4 x 4] matrix
% R_e := [3 x 3] rotation matrix (not homogeneous matrix)
% p_e := column vector [3 x 1]

% q := [n x 1] column vector. can be either numeric or symbolic
% type := [n x 1] column vector. can only be numeric [0 or 1]
% DH_table := [n x 4] matrix. can be either numeric or symbolic
    %Base = [1 0 0 200; 0 1 0 500 ; 0 0 1 0 ; 0 0 0 1];
    p_b = [0 0 0]';
    Base = [eye(3) p_b ; zeros(1,3) 1]; 
    n = size(DH_table,1);

    if ~strcmp(class(q),'sym')
        H = zeros(4,4,n);
    else
        H = sym(zeros(4,4,n));
    end

    for i = 1:n
        if type(i) == 0
            A_i = DHtrans(DH_table(i,1),DH_table(i,2)+q(i),DH_table(i,3),DH_table(i,4));
        elseif type(i) == 1
            A_i = DHtrans(DH_table(i,1)+q(i),DH_table(i,2),DH_table(i,3),DH_table(i,4));
        end

        if i > 1
            H(:,:,i) = H(:,:,i-1)*A_i;
        else
            H(:,:,i) = Base*A_i;
        end
    end
    H_e = H(:,:,end);
    R_e = H_e(1:3,1:3);
    p_e = H_e(1:3,4);

    %% visualization workspace
    
    if ~strcmp(class(q),'sym')
        for i = 1:n
            plotFrame(H(:,:,i),50);
            if i == 1
                plotFrame(Base,50);
                plot3([Base(1,4) H(1,4,i)], [Base(2,4) H(2,4,i)], [Base(3,4) H(3,4,i)],'k','linewidth',1);
            else
                A = plot3([H(1,4,i-1) H(1,4,i)], [H(2,4,i-1) H(2,4,i)], [H(3,4,i-1) H(3,4,i)],'k','linewidth',1);
           end

        end
        axis equal
        axis([-300 800 -500 500 -50 1000]);  
        xlabel('x axis')
        ylabel('y axis')
        zlabel('z axis')    

    end
    
end

function plotFrame(H,len)
% H is a homogenous transformation matrix
% len is the length of each vector to be drawn (doesn't have to be 1)
R = H(1:3,1:3);
p = H(1:3,4);
hold on;
o_i = p;
x_i = [zeros(3,1) len*R(:,1)] + [o_i o_i];
y_i = [zeros(3,1) len*R(:,2)] + [o_i o_i];
z_i = [zeros(3,1) len*R(:,3)] + [o_i o_i];

plot3(x_i(1,:),x_i(2,:),x_i(3,:),'r','lineWidth',2);
plot3(y_i(1,:),y_i(2,:),y_i(3,:),'g','lineWidth',2);
plot3(z_i(1,:),z_i(2,:),z_i(3,:),'b','lineWidth',2);


end


function T = DHtrans(par1,par2,par3,par4)
    T = (rot('z',par1));
    T = T*(trans('z',par2));
    T = T*(trans('x',par3));
    T = T*(rot('x',par4));
end