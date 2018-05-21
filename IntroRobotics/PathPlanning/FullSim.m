function FullSim(card,planning,env,robot)
    l1 = 250.5;
    l2 = 500;
    l3 = 100;
    l4 = 507.2;
    l5 = 0;
    l6 = 230;
    
    DH = robot.DH;
    type = [1 1 1 1 1 1];
    Prism = [250 250 -250 -250 250 250 250 -250 -250 250 250 250 -250 -250 -250 -250;
             30 30 30 30 30 -251 -251 -251 -251 -251 -251 30 30 -251 -251 30 ;
             265.3 -317 -317 265.3 265.3 265.3 -317 -317 265.3 265.3 -317 -317 -317 -317 265.3 265.3];
    Prism(:,:,2) = [50 50 -570 -570 50 50 50 -570 -570 50 50 50 -570 -570 -570 -570;
                    50 50 50 50 50 -126 -126 -126 -126 -126 -126 50 50 -126 -126 50 ;
                    88.5 -101 -101 88.5 88.5 88.5 -101 -101 88.5 88.5 -101 -101 -101 -101 88.5 88.5];
    Prism(:,:,3) = [62 62 -150 -150 62 62 62 -150 -150 62 62 62 -150 -150 -150 -150;
                    52 52 52 52 52 -52 -52 -52 -52 -52 -52 52 52 -52 -52 52;
                    193 -100 -100 193 193 193 -100 -100 193 193 -100 -100 -100 -100 193 193 ];
    Prism(:,:,4) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    404 404 404 404 404 150 150 150 150 150 150 404 404 150 150 404;
                    97 -112 -112 97 97 97 -112 -112 97 97 -112 -112 -112 -112 97 97];
    Prism(:,:,5) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;%138
                    150 150 150 150 150 37 37 37 37 37 37 150 150 37 37 150;
                    53 -53 -53 53 53 53 -53 -53 53 53 -53 -53 -53 -53 53 53];
    Prism(:,:,6) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    37 37 37 37 37 -17 -17 -17 -17 -17 -17 37 37 -17 -17 37;
                    44 -44 -44 44 44 44 -44 -44 44 44 -44 -44 -44 -44 44 44];
    Prism(:,:,7) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    38 38 38 38 38 -38 -38 -38 -38 -38 -38 38 38 -38 -38 38;
                    35 -79 -79 35 35 35 -79 -79 35 35 -79 -79 -79 -79 35 35];                
    Prism(:,:,8) = [50 50 -50 -50 50 50 50 -50 -50 50 50 50 -50 -50 -50 -50;
                    84 84 84 84 84 38 38 38 38 38 38 84 84 38 38 84;
                    -79 -132 -132 -79 -79 -79 -132 -132 -79 -79 -132 -132 -132 -132 -79 -79];
    Prism(:,:,9) = [58 58 -58 -58 58 58 58 -58 -58 58 58 58 -58 -58 -58 -58;
                    58 58 58 58 58 -58 -58 -58 -58 -58 -58 58 58 -58 -58 58;
                    0 -38 -38 0 0 0 -38 -38 0 0 -38 -38 -38 -38 0 0];                
    Prism(:,:,10) = [3 3 -3 -3 3 3 3 -3 -3 3 3 3 -3 -3 -3 -3;
                    3 3 3 3 3 -3 -3 -3 -3 -3 -3 3 3 -3 -3 3;
                    -38 -152 -152 -38 -38 -38 -152 -152 -38 -38 -152 -152 -152 -152 -38 -38];                    
    Prism(:,:,11) = [75 75 -75 -75 75 75 75 -75 -75 75 75 75 -75 -75 -75 -75;
                    75 75 75 75 75 -75 -75 -75 -75 -75 -75 75 75 -75 -75 75;
                    26 0 0 26 26 26 0 0 26 26 0 0 0 0 26 26];

    ws = [-200 -500 1000 ; 800 -500 1000 ; 800 500 1000 ; -200 500 1000 ; 
          -200 500 0 ; 800 500 0 ; 800 -500 0 ; -200 -500 0 ; -200 -500 1000];

    [x,y,z] = cylinder(20);
    laser = {x+600,y,z*1000};
% 
%     for i = 1:size(planning.Traject,2)
%         T = planning.Traject{2,i};
%         c = planning.Traject{3,i};
%         q = planning.Path{i};
%         v_max = robot.vel.v_max;
%         a_max = robot.accl.a_max;
%         figure('units','normalized','outerposition',[0 0 1 1])
%         plotTraj(T,q,c,v_max,a_max)
%         pause(0.5);
%     end 
       
tic    
    cl = card.lists;
    tg = env.targetzone;
    figure('units','normalized','outerposition',[0 0 1 1])
    plot3(ws(:,1),ws(:,2),ws(:,3),'k','linewidth',2)
    hold on
    surf(laser{1},laser{2},laser{3});
    for i = 1:numel(cl)
        plot3(cl{i}{1}(1),cl{i}{1}(2),cl{i}{1}(3),'ok','linewidth',5)
        plot3(tg{i}{1}(1),tg{i}{1}(2),tg{i}{1}(3),'ob','linewidth',5)
    end
    
    axis equal
    axis([-500 800 -500 500 0 1000]);
    view(3);
    %plotLink(planning.Path{1,5}(:,end),DH,type,Prism);
    
    all_Path = planning.Path;
    Traject = planning.Traject(1,:);
    Duration = planning.Traject(2,:);
    for p_ind = 1:numel(Traject)
        for i = 1: numel(all_Path{p_ind}(1,:))
            q1 = all_Path{p_ind}(1,i);
            q2 = all_Path{p_ind}(2,i);
            q3 = all_Path{p_ind}(3,i);
            q4 = all_Path{p_ind}(4,i);
            q5 = all_Path{p_ind}(5,i);
            q6 = all_Path{p_ind}(6,i);
            
            p_e = [l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - l6*(sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                   l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l6*(sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2))) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                                                                                                l1 - l6*(cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2)];
            if (mod(p_ind,4) == 0)||(mod(p_ind,4) == 3), plot3(p_e(1),p_e(2),p_e(3),'*k','linewidth',4);
            else plot3(p_e(1),p_e(2),p_e(3),'*r','linewidth',4); end
        end
        for t = planning.TimetoStart{p_ind}:0.1:planning.TimetoFinish{p_ind}
            tau = t-planning.TimetoStart{p_ind};
            [q_t,~,~] = TrajectEval(Traject{p_ind},tau);
            q1 = q_t(1);
            q2 = q_t(2);
            q3 = q_t(3);
            q4 = q_t(4);
            q5 = q_t(5);
            q6 = q_t(6);
                        
            p_e = [l4*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2)) - l6*(sin(q5 - pi/6)*(sin(q4)*sin(q1 - pi/2) - cos(q4)*(cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) - cos(q5 - pi/6)*(cos(q1 - pi/2)*cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q1 - pi/2)*cos(q3 - pi/3)*sin(q2 + pi/2))) + l2*cos(q1 - pi/2)*cos(q2 + pi/2) + l3*cos(q1 - pi/2)*cos(q2 + pi/2)*cos(q3 - pi/3) - l3*cos(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                   l4*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2)) + l6*(sin(q5 - pi/6)*(cos(q1 - pi/2)*sin(q4) + cos(q4)*(cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3))) + cos(q5 - pi/6)*(cos(q2 + pi/2)*sin(q1 - pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q1 - pi/2)*sin(q2 + pi/2))) + l2*cos(q2 + pi/2)*sin(q1 - pi/2) + l3*cos(q2 + pi/2)*cos(q3 - pi/3)*sin(q1 - pi/2) - l3*sin(q1 - pi/2)*sin(q2 + pi/2)*sin(q3 - pi/3);
                                                                                                                                                                                l1 - l6*(cos(q5 - pi/6)*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) - cos(q4)*sin(q5 - pi/6)*(cos(q2 + pi/2)*sin(q3 - pi/3) + cos(q3 - pi/3)*sin(q2 + pi/2))) - l4*(cos(q2 + pi/2)*cos(q3 - pi/3) - sin(q2 + pi/2)*sin(q3 - pi/3)) + l2*sin(q2 + pi/2) + l3*cos(q2 + pi/2)*sin(q3 - pi/3) + l3*cos(q3 - pi/3)*sin(q2 + pi/2)];
            if (mod(p_ind,4) == 0)||(mod(p_ind,4) == 3)
                Prism_G = fkPrism(q_t,DH,type,Prism);

                link1 = plot3(Prism_G(1,:,1),Prism_G(2,:,1),Prism_G(3,:,1),'b','linewidth',1);
                link2 = plot3(Prism_G(1,:,2),Prism_G(2,:,2),Prism_G(3,:,2),'b','linewidth',1);
                link3 = plot3(Prism_G(1,:,3),Prism_G(2,:,3),Prism_G(3,:,3),'b','linewidth',1);
                link4 = plot3(Prism_G(1,:,4),Prism_G(2,:,4),Prism_G(3,:,4),'b','linewidth',1);
                link5 = plot3(Prism_G(1,:,5),Prism_G(2,:,5),Prism_G(3,:,5),'b','linewidth',1);
                link6 = plot3(Prism_G(1,:,6),Prism_G(2,:,6),Prism_G(3,:,6),'b','linewidth',1);
                link7 = plot3(Prism_G(1,:,7),Prism_G(2,:,7),Prism_G(3,:,7),'b','linewidth',1);
                link8 = plot3(Prism_G(1,:,8),Prism_G(2,:,8),Prism_G(3,:,8),'b','linewidth',1);           
                link9 = plot3(Prism_G(1,:,9),Prism_G(2,:,9),Prism_G(3,:,9),'b','linewidth',1);
                link10 = plot3(Prism_G(1,:,10),Prism_G(2,:,10),Prism_G(3,:,10),'b','linewidth',1);           
                link11 = plot3(Prism_G(1,:,11),Prism_G(2,:,11),Prism_G(3,:,11),'k','linewidth',1);           

                plot3(p_e(1),p_e(2),p_e(3),'.k','linewidth',3);
                pause(0.1);
                if p_ind ~= numel(all_Path)
                    delete(link1);
                    delete(link2);
                    delete(link3);
                    delete(link4);
                    delete(link5);
                    delete(link6);
                    delete(link7);
                    delete(link8);
                    delete(link9);
                    delete(link10);
                    delete(link11);
                else
                    if t < planning.TimetoEnd
                        delete(link1);
                        delete(link2);
                        delete(link3);
                        delete(link4);
                        delete(link5);
                        delete(link6);
                        delete(link7);
                        delete(link8);
                        delete(link9);
                        delete(link10);
                        delete(link11);
                    end
                end                
            else
                Prism_G = fkPrism(q_t,DH,type,Prism);

                link1 = plot3(Prism_G(1,:,1),Prism_G(2,:,1),Prism_G(3,:,1),'b','linewidth',1);
                link2 = plot3(Prism_G(1,:,2),Prism_G(2,:,2),Prism_G(3,:,2),'b','linewidth',1);
                link3 = plot3(Prism_G(1,:,3),Prism_G(2,:,3),Prism_G(3,:,3),'b','linewidth',1);
                link4 = plot3(Prism_G(1,:,4),Prism_G(2,:,4),Prism_G(3,:,4),'b','linewidth',1);
                link5 = plot3(Prism_G(1,:,5),Prism_G(2,:,5),Prism_G(3,:,5),'b','linewidth',1);
                link6 = plot3(Prism_G(1,:,6),Prism_G(2,:,6),Prism_G(3,:,6),'b','linewidth',1);
                link7 = plot3(Prism_G(1,:,7),Prism_G(2,:,7),Prism_G(3,:,7),'b','linewidth',1);
                link8 = plot3(Prism_G(1,:,8),Prism_G(2,:,8),Prism_G(3,:,8),'b','linewidth',1);           
                link9 = plot3(Prism_G(1,:,9),Prism_G(2,:,9),Prism_G(3,:,9),'b','linewidth',1);
                link10 = plot3(Prism_G(1,:,10),Prism_G(2,:,10),Prism_G(3,:,10),'b','linewidth',1);           
                %link11 = plot3(Prism_G(1,:,11),Prism_G(2,:,11),Prism_G(3,:,11),'b','linewidth',1);           

                plot3(p_e(1),p_e(2),p_e(3),'.r','linewidth',3);
                pause(0.1);
                if p_ind ~= numel(all_Path)
                    delete(link1);
                    delete(link2);
                    delete(link3);
                    delete(link4);
                    delete(link5);
                    delete(link6);
                    delete(link7);
                    delete(link8);
                    delete(link9);
                    delete(link10);
                else
                    if t < planning.TimetoEnd
                        delete(link1);
                        delete(link2);
                        delete(link3);
                        delete(link4);
                        delete(link5);
                        delete(link6);
                        delete(link7);
                        delete(link8);
                        delete(link9);
                        delete(link10);
                    end
                end                     


            end

        end

    end
toc
%}    
%{
for i = 1:numel(all_Path)    
    Path = all_Path{i};
    if planning.Reach(i)
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

            link1 = plot3(Prism_G(1,:,1),Prism_G(2,:,1),Prism_G(3,:,1),'b','linewidth',1);
            link2 = plot3(Prism_G(1,:,2),Prism_G(2,:,2),Prism_G(3,:,2),'b','linewidth',1);
            link3 = plot3(Prism_G(1,:,3),Prism_G(2,:,3),Prism_G(3,:,3),'b','linewidth',1);
            link4 = plot3(Prism_G(1,:,4),Prism_G(2,:,4),Prism_G(3,:,4),'b','linewidth',1);
            link5 = plot3(Prism_G(1,:,5),Prism_G(2,:,5),Prism_G(3,:,5),'b','linewidth',1);
            link6 = plot3(Prism_G(1,:,6),Prism_G(2,:,6),Prism_G(3,:,6),'b','linewidth',1);
            link7 = plot3(Prism_G(1,:,7),Prism_G(2,:,7),Prism_G(3,:,7),'b','linewidth',1);
            link8 = plot3(Prism_G(1,:,8),Prism_G(2,:,8),Prism_G(3,:,8),'b','linewidth',1);

            pause(0.3)
            if j < size(Path,2)
                plot3([ef_path(1,j) ef_path(1,j+1)],[ef_path(2,j) ef_path(2,j+1)],[ef_path(3,j) ef_path(3,j+1)],'r','linewidth',2);
            end
            if i ~= numel(all_Path)
                delete(link1);
                delete(link2);
                delete(link3);
                delete(link4);
                delete(link5);
                delete(link6);
                delete(link7);
                delete(link8);
            else
                if j < size(Path,2)
                    delete(link1);
                    delete(link2);
                    delete(link3);
                    delete(link4);
                    delete(link5);
                    delete(link6);
                    delete(link7);
                    delete(link8);
                end
            end
        end
    else
        plot3(Path(1,:),Path(2,:),Path(3,:),'--k','linewidth',2);
        pause(1);
    end
end
toc
    
%}
end

function [t_v,q_v,qd_v,qdd_v] = plotTraj(T,q,c,v_max,a_max)

D = size(q,1);
N = size(q,2);

t_i = cumsum([0;T(1:end-1)]);
t_v = [];
q_v = [];
qd_v = [];
qdd_v = [];
for i = 1:D
    subplot(3,D,D*(1-1)+i)
%    title('q' + string(i))
    hold on;
    plot([t_i;t_i(end)+T(end)],q(i,:),'ko','linewidth',2)
    grid on;

    subplot(3,D,D*(2-1)+i)
 %   title('qd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*v_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*v_max(i,:),'k--')
    grid on;

    subplot(3,D,D*(3-1)+i)
  %  title('qdd' + string(i))
    hold on;
    plot([0 t_i(end)+T(end)],[1 1]*a_max(i,:),'k--')
    plot([0 t_i(end)+T(end)],-[1 1]*a_max(i,:),'k--')
    grid on;


    for k = 1:N-1
        t = t_i(k):0.01:(t_i(k)+T(k));
        tau = (t-t_i(k));
        q_t = c(:,k,i)'*[ones(size(tau));tau;tau.^2;tau.^3];
        qd_t = c(:,k,i)'*[zeros(size(tau));ones(size(tau));2*tau;3*tau.^2];
        qdd_t = c(:,k,i)'*[zeros(size(tau));zeros(size(tau));2*ones(size(tau));6*tau];
        subplot(3,D,D*(1-1)+i)
        plot(t,q_t)
        subplot(3,D,D*(2-1)+i)
        plot(t,qd_t)
        subplot(3,D,D*(3-1)+i)
        plot(t,qdd_t)

    end
end
end

function plotLink(q,DH,type,Prism)
    Prism_G = fkPrism(q,DH,type,Prism);

    link1 = plot3(Prism_G(1,:,1),Prism_G(2,:,1),Prism_G(3,:,1),'b','linewidth',1);
    link2 = plot3(Prism_G(1,:,2),Prism_G(2,:,2),Prism_G(3,:,2),'b','linewidth',1);
    link3 = plot3(Prism_G(1,:,3),Prism_G(2,:,3),Prism_G(3,:,3),'b','linewidth',1);
    link4 = plot3(Prism_G(1,:,4),Prism_G(2,:,4),Prism_G(3,:,4),'b','linewidth',1);
    link5 = plot3(Prism_G(1,:,5),Prism_G(2,:,5),Prism_G(3,:,5),'b','linewidth',1);
    link6 = plot3(Prism_G(1,:,6),Prism_G(2,:,6),Prism_G(3,:,6),'b','linewidth',1);
    link7 = plot3(Prism_G(1,:,7),Prism_G(2,:,7),Prism_G(3,:,7),'b','linewidth',1);
    link8 = plot3(Prism_G(1,:,8),Prism_G(2,:,8),Prism_G(3,:,8),'b','linewidth',1);           
    link9 = plot3(Prism_G(1,:,9),Prism_G(2,:,9),Prism_G(3,:,9),'b','linewidth',1);
    link10 = plot3(Prism_G(1,:,10),Prism_G(2,:,10),Prism_G(3,:,10),'b','linewidth',1);           
    link11 = plot3(Prism_G(1,:,11),Prism_G(2,:,11),Prism_G(3,:,11),'b','linewidth',1);     
end