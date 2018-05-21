%Sorawit Inprom
%12/02/2018
%this script use to plot workspace of scalar robot which have configuration
%at q1=[-p1,pi], q2=[-pi/2,pi/2], q3=[-3pi/4,3pi/4] and assume q4 = 0
type = [1 1 0 1]';
DH = [0 0 0.5 0 ; 0 0 0.5 pi ; 0 0.5 0 0 ; 0 2.4 0 0];
q1 = linspace(-pi,pi,10);
q2 = linspace(-pi/2,pi/2,10);
q3 = linspace(-3*pi/4,3*pi/4,20);
q = [0 0 0 0]';
[H, H_e, R_e, p_e] = forwardKinematics(q,DH,type);
old_p_e = p_e;
for i = 1:size(q1,2)
    for j = 1:size(q2,2)
        for k = 1:size(q3,2)
            q = [q1(i) q2(j) q3(k) 0]';
            [H, H_e, R_e, p_e] = forwardKinematics(q,DH,type);
             hold on
             %plot3([old_p_e(1) p_e(1)],[old_p_e(2) p_e(2)], [old_p_e(3) p_e(3)],'r');
             plot3(p_e(1),p_e(2),p_e(3),'ro');
             axis equal 
             axis([-2 2 -2 2 -5 3])
            
             old_p_e = p_e; 
        end
    end
end
