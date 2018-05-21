tf = tf([1],[2.06 2060.2 255.01 10]);
z = zero(tf);
p = pole(tf);
a = 50;
[sigma,omega] = closedLoopPoles(z,p,'OS',0.12, 1);
mag = productMagnitude(sigma,omega,z,p,a);
K = 1/mag;

new_tf = tf([1],[2.06 2060.2 255.01 10+K*50]);