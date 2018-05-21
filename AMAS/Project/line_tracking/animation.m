line_color = 'b';
%get param from simulink
x = [x_sim.Data y_sim.Data psi_sim.Data]; %x = [x_G y_G psi]
D = D_sim.Data;
steering = rad2deg(delta_steer_sim.Data);
v = v_x_sim.Data;
t = tout;

l = vehical_length;
w = vehical_length;
r_CG = distance_of_CG;
Pos_R = [ l-r_CG l-r_CG -r_CG -r_CG l-r_CG; w/2 -w/2 -w/2 w/2 w/2];

%Curve
if(test_case == 0)
    subplot(3,2,[1,3]);
    hold on
elseif(test_case == 1)
    subplot(3,2,[1,3]);
    hold on
elseif(test_case == 2)
    path_x = linspace(0,max(x(:,1))+0.2*max(x(:,1)));
    path_y = tan(deg2rad(Theta))*(path_x - x0) + y0;
    subplot(3,2,[1,3]);
    hold on
    line(path_x,path_y);
    
    %target degree
    subplot(3,2,2);
    hold on
    plot([min(t) max(t)],[Theta Theta],'k--');
    
    %error
    subplot(3,2,4);
    hold on
    plot([min(t) max(t)],[0 0],'k--');
    
elseif(test_case == 3)
    path_x = linspace(0,max(x(:,1))+0.2*max(x(:,1)));
    path_y = sqrt(path_x/parabora_coefficient);
    subplot(3,2,[1,3]);
    hold on
    plot(path_x,path_y);
    
    %target degree
    subplot(3,2,2);
    hold on
    plot(t,rad2deg(atan(1./(2*sqrt(parabora_coefficient*x(:,1))))),'k--');
    
    %error
    subplot(3,2,4);
    hold on
    plot([min(t) max(t)],[0 0],'k--');
    
elseif(test_case == 4)
    path_xR = linspace(0,Radius);
    path_yR = -sqrt(-(path_xR.^2)+Radius^2)+Center_R(2); % left(-) right(+)
    path_R = [path_xR ; path_yR];
    path_G = rotationR2G*path_R + [x_init ; y_init];
    hold on
    subplot(3,2,[1,3]);
    plot(path_G(1,:),path_G(2,:),'k--');
    
    
end

%animate
for i = 1:numel(t)-1
    rotationR2G = [cos(x(i,3)) -sin(x(i,3)) ; sin(x(i,3)) cos(x(i,3))];
    Pos_G = rotationR2G*Pos_R + [x(i,1) ; x(i,2)];
    hold on
    subplot(3,2,[1,3]);
    title('line tracking')
    car = plot(Pos_G(1,:),Pos_G(2,:),'k','linewidth',2);
    if(i > 1)    
        plot([x(i-1,1) x(i,1)],[x(i-1,2) x(i,2)],line_color,'linewidth',1);
    end
    axis equal
    %axis([-5 2 -2 5]);
    axis([min(x(:,1))-0.1*max(x(:,1)) max(x(:,1))+0.1*max(x(:,1)) min(x(:,2))-0.1*max(x(:,2)) max(x(:,2))+0.1*max(x(:,2))]);
    
    subplot(3,2,2);
    title('target Degree')
    hold on
    plot([t(i) t(i+1)],[rad2deg(x(i,3)) rad2deg(x(i+1,3))],line_color,'linewidth',2);
    axis([min(t) max(t) min(rad2deg(x(:,3)))-0.1*max(rad2deg(x(:,3))) max(rad2deg(x(:,3)))+0.1*max(rad2deg(x(:,3)))]);
    
    subplot(3,2,4);
    title('error')
    hold on
    plot([t(i) t(i+1)],[D(i) D(i+1)],line_color,'linewidth',2);
    axis([min(t) max(t) min(D)-0.1*max(D) max(D)+0.1*max(D)]);
    
    subplot(3,2,5);
    title('delta steer')
    hold on
    plot([t(i) t(i+1)],[steering(i) steering(i+1)],line_color,'linewidth',2);
    axis([min(t) max(t) min(steering)-0.1*max(steering) max(steering)+0.1*max(steering)]);
    
    subplot(3,2,6);
    title('velocity')
    hold on
    plot([t(i) t(i+1)],[v(i) v(i+1)],line_color,'linewidth',2);
    axis([min(t) max(t) min(v)-0.1*max(v) max(v)+0.1*max(v)]);
    
    pause(t(i+1)-t(i));
    if(i < numel(t)-1)
        delete(car);
    end
    
end






