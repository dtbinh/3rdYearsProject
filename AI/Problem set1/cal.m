table = [1.5 9.2 4.5 ; 2.2 4.3 6.6 ; 1.6 6.5 5.5 ; 5.7 2.4 2];
cost1 = 0;
cost2 = 0;
for i = 1:size(table(:,1))
    hx1 = 11 - 1.5*table(i,1) - 0.6*table(i,2);
    hx2 = -2.3 + 6.1*table(i,1) - 0.9*table(i,1)^2;
    %display(hx1);
    %display(hx2);
    cost1 = cost1+(hx1-table(i,3))^2;
    cost2 = cost2+(hx2-table(i,3))^2;
    
end
display(cost1);
display(cost2);

