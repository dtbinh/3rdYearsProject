function [q_ok,status] = Colis_Detec(q,DH_table,type,Prism_L,Colis)
    %q:= all interested configration [NxD]
    %DH_table:= DH_table of robot
    %type:= type of robot
    %Prism_L:= Prism of each link in Local Coordinate Flame [3x8xD]
    %Colis:= Boundary Area(x,y,z) that robot must move inside [3x2]
    %q_ok:= Inside area configration [NxD]
    %status:= status in x,y,z of each configuration [Nx3]
    
    N = size(q,1); % number of interested configuration
    D = size(q,2); % dimension of interested configuration
    
    status = ones(N,3);
    q_ok = zeros(N,D);
    ind = 1;
    for i = 1:N
        Prism_G = fkPrism(q(i,:),DH_table,type,Prism_L);
        for j = 1:3
            if ~(all(all(Prism_G(j,:,:) > Colis(j,1)) ~= 0) && all(all(Prism_G(j,:,:) < Colis(j,2)) ~= 0))
                status(i,j) = false;
            end
        end
    
        if all(status(i,:) == 1)
            q_ok(ind,:) = q(i,:);
            ind = ind+1;
        else
            q_ok(ind,:) = NaN;
            ind = ind+1;
        end
    end   
end