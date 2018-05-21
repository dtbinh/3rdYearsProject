function [q_can,status] = jointLimit(q,limit)
    status = [];
    q_can = [];
    for i = 1:size(q,2)
        if all((q(:,i) >= limit(:,1))) && all((q(:,i) <= limit(:,2)))
            status(1,i) = 1;
        else
            status(1,i) = 0;
        end
        
    end
    index = 1;
    for i = 1:size(q,2)
        if status(1,i) == 1
            q_can(:,index) = q(:,i);
            index = index + 1;
            
        end
    end
end