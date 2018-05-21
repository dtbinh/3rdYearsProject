l = [250.5 500 100 507.2 0 230]';

Changpowbot = [ -pi/2    l(1)     0       pi/2 ; 
                 pi/2    0       l(2)        0 ; 
                -pi/3    0       l(3)    -pi/2 ; 
                 0      -l(4)     0       pi/2 ; 
                -pi/6    l(5)     0      -pi/2 ; 
                 0      -l(6)     0       pi   ];

Ning_bot = [ 0 231 0 pi/2 ;
             -pi/2 0 -360 0;
             0 0 -36 -pi/2;
             0 75+501 0 pi/2;
             0 0 0 -pi/2;
             0 150 0 0];
         
type = [1 1 1 1 1 1]';
%q = [0 0 0 0 0 0]';
%[H, H_e, R_e, p_e] = forwardKinematics(q,Changpowbot,type);
q1 = linspace(deg2rad(-135),deg2rad(135),50);
q2 = linspace(deg2rad(-90),deg2rad(100),50);
q3 = linspace(deg2rad(-90),deg2rad(90),50);
q4 = linspace(deg2rad(0),deg2rad(180),50);
q5 = linspace(deg2rad(-90),deg2rad(90),50);
q6 = linspace(deg2rad(0),deg2rad(180),50);
sampling = 1;
q = [0 0 0 0 0 0]';
for i = 1:size(q1,2)
    for j = 1:size(q2,2)
        for k = 1:size(q3,2)
            q = [q1(i) q2(j) q3(k) 0 0 0]';
            [H, H_e, R_e, p_e] = forwardKinematics(q,Ning_bot,type);
            %RPY = cvtRot2RPY(R_e);            
            data(sampling,1:7) = [sampling 0 0 0 p_e(1) p_e(2) p_e(3)];  
            sampling = sampling + 1;          
        end
    end
end

Base = [1 0 0 250 ; 0 1 0 500 ; 0 0 1 0 ; 0 0 0 1];
plate1 = [1 0 0 375 ; 0 1 0 175 ; 0 0 1 0 ; 0 0 0 1];
plate2 = [1 0 0 375 ; 0 1 0 825 ; 0 0 1 0 ; 0 0 0 1];
plotFrame(Base,50);
plotFrame(plate1,50);
plotFrame(plate2,50);

plot3(data(:,5),data(:,6),data(:,7),'k.');
%hold on
%simforwardKinematics([0 0 0 0 0 0]',Changpowbot,type);
axis([0 1000 0 1000 0 1000]);

xlabel('x axis')
ylabel('y axis')
zlabel('z axis')

