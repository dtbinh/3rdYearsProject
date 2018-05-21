q = sym('q',[3,1]);
l = sym('l',[3,1]);
h = sym('h');

A = [ -cos(q(1))*(h+cos(q(2))*(l(2)+l(3)+q(3))) , sin(q(1))*sin(q(2))*(l(2)+l(3)+q(3)) , -sin(q(1))*cos(q(2)) ;
      -sin(q(1))*(h+cos(q(2))*(l(2)+l(3)+q(3))) , -cos(q(1))*sin(q(2))*(l(2)+l(3)+q(3)) ,  cos(q(1))*cos(q(2)) ;
                                              0 ,            cos(q(2))*(l(2)+l(3)+q(3)) ,            sin(q(2)) ];
                                          
det_A = simplify(det(A))