function AnimateBot(Path)
    l1 = 250.5;
    l2 = 500;
    l3 = 100;
    l4 = 507.2;
    l5 = 0;
    l6 = 230;
    
    DH = [-pi/2 250.5 0 pi/2;
           pi/2 0 500 0;
           -1.0472 0 100 -1.5708;
           0 -507.2 0 1.5708;
           -0.5236 0 0 -1.5708;
           0 -230 0 3.14];
    type = [1 1 1 1 1 1];
    Prism = [200 200 -200 -200 200 200 200 -200 -200 200 200 200 -200 -200 -200 -200;
             30 30 30 30 30 -156.5 -156.5 -156.5 -156.5 -156.5 -156.5 30 30 -156.5 -156.5 30 ;
             265.3 -200 -200 265.3 265.3 265.3 -200 -200 265.3 265.3 -200 -200 -200 -200 265.3 265.3];
    Prism(:,:,2) = [50 50 -570 -570 50 50 50 -570 -570 50 50 50 -570 -570 -570 -570;
                    51.5 51.5 51.5 51.5 51.5 -126 -126 -126 -126 -126 -126 51.5 51.5 -126 -126 51.5 ;
                    88.5 -96 -96 88.5 88.5 88.5 -96 -96 88.5 88.5 -96 -96 -96 -96 88.5 88.5];
    Prism(:,:,3) = [62 62 -150 -150 62 62 62 -150 -150 62 62 62 -150 -150 -150 -150;
                    46.5 46.5 46.5 46.5 46.5 -46.5 -46.5 -46.5 -46.5 -46.5 -46.5 46.5 46.5 -46.5 -46.5 46.5;
                    174 -127 -127 174 174 174 -127 -127 174 174 -127 -127 -127 -127 174 174 ];
    Prism(:,:,4) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    404 404 404 404 404 -50 -50 -50 -50 -50 -50 404 404 -50 -50 404;
                    97 -112 -112 97 97 97 -112 -112 97 97 -112 -112 -112 -112 97 97];
    Prism(:,:,5) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    95.1 95.1 95.1 95.1 95.1 -42 -42 -42 -42 -42 -42 95.1 95.1 -42 -42 95.1;
                    35 -145 -145 35 35 35 -145 -145 35 35 -145 -145 -145 -145 35 35];
    Prism(:,:,6) = [40 40 -40 -40 40 40 40 -40 -40 40 40 40 -40 -40 -40 -40;
                    40 40 40 40 40 -40 -40 -40 -40 -40 -40 40 40 -40 -40 40;
                    0 -105 -105 0 0 0 -105 -105 0 0 -105 -105 -105 -105 0 0];

    ws = [-200 -500 1000 ; 800 -500 1000 ; 800 500 1000 ; -200 500 1000 ; 
          -200 500 0 ; 800 500 0 ; 800 -500 0 ; -200 -500 0 ; -200 -500 1000];
    
    figure('units','normalized','outerposition',[0 0 1 1])
    plot3(ws(:,1),ws(:,2),ws(:,3),'k','linewidth',2)
    axis equal
    axis([-200 800 -500 500 0 1000]);
    view(2);
    pause(3);
    
    for j = 1:size(Path,2)
        q1 = Path(1,j);
        q2 = Path(2,j);
        q3 = Path(3,j);
        q4 = Path(4,j);
        q5 = Path(5,j);
        q6 = Path(6,j);
        p_e = [l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - l6*(sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
               l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l6*(sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2))) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                                                                                            l1 - l6*(cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2)];
        ef_path(:,j) = p_e;     
    end
    for j = 1:size(Path,2)
        Prism_G = fkPrism(Path(:,j)',DH,type,Prism);
                                                                                                                                                      
        hold on
        
        link1 = plot3(Prism_G(1,:,1),Prism_G(2,:,1),Prism_G(3,:,1),'k','linewidth',2);
        link2 = plot3(Prism_G(1,:,2),Prism_G(2,:,2),Prism_G(3,:,2),'r','linewidth',2);
        link3 = plot3(Prism_G(1,:,3),Prism_G(2,:,3),Prism_G(3,:,3),'b','linewidth',2);
        link4 = plot3(Prism_G(1,:,4),Prism_G(2,:,4),Prism_G(3,:,4),'k','linewidth',2);
        link5 = plot3(Prism_G(1,:,5),Prism_G(2,:,5),Prism_G(3,:,5),'r','linewidth',2);
        link6 = plot3(Prism_G(1,:,6),Prism_G(2,:,6),Prism_G(3,:,6),'b','linewidth',2);
        
        pause(0.5)
        if j < size(Path,2)
            plot3([ef_path(1,j) ef_path(1,j+1)],[ef_path(2,j) ef_path(2,j+1)],[ef_path(3,j) ef_path(3,j+1)],'r','linewidth',2);
            delete(link1);
            delete(link2);
            delete(link3);
            delete(link4);
            delete(link5);
            delete(link6);
        end  

    end


end

