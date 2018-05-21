function [Tall, Tend, Rend, Pend] = HW3(q,DH_par,type) %type[0,1] = [revolute,prismatic]
    T = zeros(4);
    for i = 1:numel(DH_par(:,1))
        if type(i) == 0
            DH_par(i,1) = DH_par(i,1)+q(i);
        elseif type(i) == 1
            DH_par(i,3) = DH_par(i,3)+q(i);
        end
        T(:,:,i) = DHtrans(DH_par(i,:)');
    end
    Tall = T;
    for j = 2:numel(DH_par(:,1))
        for k = 2:j
            Tall(:,:,j) = Tall(:,:,k-1)*T(:,:,k);
        end
    end
    
    %Tall = Tall;
    Tend = Tall(:,:,numel(DH_par(:,1)));
    Rend = Tend(1:3,1:3);
    Pend = Tend(1:3,4);
    hold on
    animation(Tall);
end

function animation(Tall)
   l = 40;
   x = 20;
   y = 500;
   z = 1;
   Tbase = [1 0 0 x ; 0 1 0 y ; 0 0 1 z ; 0 0 0 1];
   for i = 1:numel(Tall(1,1,:))
       Tall(:,:,i) = Tbase*Tall(:,:,i);
   end
   plot3([x x+l],[y y],[z,z],'r','linewidth',2);
   plot3([x x],[y y+l],[z z],'g','linewidth',2);
   plot3([x x],[y y],[z z+l],'b','linewidth',2);  
   plot3([x Tall(1,4,1)],[y Tall(2,4,1)],[z Tall(3,4,1)],'k','linewidth',3);
       
   for i = 1:numel(Tall(1,1,:))
       Pos = Tall(1:3,4,i);
       Rot = Tall(1:3,1:3,i);
       if i < numel(Tall(1,1,:))
            plot3([Tall(1,4,i) Tall(1,4,i+1)],[Tall(2,4,i) Tall(2,4,i+1)],[Tall(3,4,i) Tall(3,4,i+1)],'k','linewidth',3);
       end
       plot3([Pos(1) Pos(1)+(l*Rot(1,1))],[Pos(2) Pos(2)+(l*Rot(2,1))],[Pos(3) Pos(3)+(l*Rot(3,1))],'r','linewidth',2);
       plot3([Pos(1) Pos(1)+(l*Rot(1,2))],[Pos(2) Pos(2)+(l*Rot(2,2))],[Pos(3) Pos(3)+(l*Rot(3,2))],'g','linewidth',2);
       plot3([Pos(1) Pos(1)+(l*Rot(1,3))],[Pos(2) Pos(2)+(l*Rot(2,3))],[Pos(3) Pos(3)+(l*Rot(3,3))],'b','linewidth',2);
       axis equal
       axis([-200 1200 -200 1200 0 1200]);     
       xlabel('x axis')
       ylabel('y axis')
       zlabel('z axis')
   end
   
end

    
     
  