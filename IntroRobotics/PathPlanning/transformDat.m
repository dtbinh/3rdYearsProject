function [coef_all,t_i_all,T_all] = transformDat(planning)
    Traject_all = planning.Traject(1,:);
    N = numel(Traject_all);  
    coef_all = cell(0);
    t_i_all = cell(0);
    T_all = cell(0);
    
    for p_ind = 1:N
        traject_i = Traject_all{p_ind};
        K = numel(traject_i);
        coef_i = zeros(4,K,6);
        t_i = zeros(K,1);
        T_i = zeros(K,1);
        for k = 1:K
            sub_traject_i = traject_i{k};
            coef_i(:,k,:) = sub_traject_i.coef;
            t_i(k) = sub_traject_i.initTime;
            T_i(k) = sub_traject_i.duration;
        end
        coef_all{p_ind} = coef_i;
        t_i_all{p_ind} = t_i;
        T_all{p_ind} = T_i;
    end
end