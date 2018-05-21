function [q_t,qd_t,qdd_t] = Main(planning)
   Traject = planning.Traject(1,:);
   index = 1;
    for p_ind = 1:numel(Traject)    
        for t = planning.TimetoStart{p_ind}:0.1:planning.TimetoFinish{p_ind}
            tau = t-planning.TimetoStart{p_ind};
            q_t(index,1) = t;
            qd_t(index,1) = t;
            qdd_t(index,1) = t;
            [q_t(index,2:7),qd_t(index,2:7),qdd_t(index,2:7)] = TrajectEval(Traject{p_ind},tau);
            index = index+1;
        end
    end
    assignin('base','q_t',q_t)
    assignin('base','qd_t',qd_t)
    assignin('base','qdd_t',qdd_t)
    %set_param('Full_sim/From Workspace','q_t','q_t')
    %set_param('Full_sim/From Workspace1','qd_t','qd_t')
    %set_param('Full_sim/From Workspace2','qdd_t','qdd_t')
    sim('animation',[0,planning.TimetoEnd])
end