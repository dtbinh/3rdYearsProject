x = 2;
y = 4;
l2 = 3;
l3 = 3;
L = sqrt(x^2 + y^2);
c3 = (L^2 - l2^2 - l3^2)/(2*l2*l3);
s3 = [sqrt(1-c3^2) -sqrt(1-c3^2)]'; 
q3 = [atan2(s3(1),c3) atan2(s3(2),c3)]';
display(rad2deg(q3));

b = [atan((l3*sin(q3(1)))/(l2 + l3*cos(q3(1)))) atan((l3*sin(q3(2)))/(l2 + l3*cos(q3(2))))]';
display(rad2deg(b));

display(rad2deg(atan(y/x)));
q2 = [atan(y/x)-b(1) atan(y/x)-b(2)]';
display(rad2deg(q2));

