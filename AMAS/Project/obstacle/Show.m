x = [x_sim1.Data.*100 y_sim1.Data.*100 psi_sim1.Data]; %x = [x_G y_G psi]
t = tout;

l = vehical_length*100;
w = vehical_length*100;
r_CG = distance_of_CG*100;
Pos_R = [ l-r_CG l-r_CG -r_CG -r_CG l-r_CG; w/2 -w/2 -w/2 w/2 w/2];

pltRoad([o_x1 o_y1 ; o_x2 o_y2]);
for i = 1:numel(t)-1
    rotationR2G = [cos(x(i,3)) -sin(x(i,3)) ; sin(x(i,3)) cos(x(i,3))];
    Pos_G = rotationR2G*Pos_R + [x(i,1) ; x(i,2)];
    car = plot(Pos_G(1,:),Pos_G(2,:),'k','linewidth',1);
    if(i > 1)    
        plot([x(i-1,1) x(i,1)],[x(i-1,2) x(i,2)],'g','linewidth',1);
    end
    
    pause(t(i+1)-t(i));
    if(i < numel(t)-1)
        delete(car);
    end
end