%Sorwait Inprom
%6/5/2018
%This function use to evaluate trajectory at time t

function [q_t,qd_t,qdd_t] = trajEval(Traject,t)
    % Traject := Structer of Trajectory has 3 attributes (coefficient,initial time, duration time)
    % t := time to evaluate trajectory

    % q_t := trajectory at time t
    % qd_t := velocity at time t
    % qdd_t := acceleration at time t
    for i = 1:numel(Traject)
        c = Traject{i}.coef;
        t_i = Traject{i}.initTime;
        T = Traject{i}.duration;
        if t <= (t_i+T), break; else continue; end
    end
    tau = t-t_i;
    for i = 1:size(c,3)
        q_t(i) = c(:,1,i)'*[ones(size(tau));tau;tau.^2;tau.^3];
        qd_t(i) = c(:,1,i)'*[zeros(size(tau));ones(size(tau));2*tau;3*tau.^2];
        qdd_t(i) = c(:,1,i)'*[zeros(size(tau));zeros(size(tau));2*ones(size(tau));6*tau];
    end
end

