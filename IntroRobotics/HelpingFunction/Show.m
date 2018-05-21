function Show(q,DH_table)
    DH = DH_table;
    type = [1 1 1 1 1 1]';
    [~, H_e, ~, ~, ~] = simforwardKinematics(q,DH,type);
    format shortG
    display(H_e)
end