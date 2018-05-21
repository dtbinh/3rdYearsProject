%Sorrawit Inprom, 7/11/2017, This is function calculates magnitude of
%closed-loop poles
function mag = productMagnitude(sigma,omega,z,p,a)
mag = a;   
for i = 1:numel(z)
    mag = mag*sqrt((omega-imag(z(i)))^2+(sigma-real(z(i)))^2);
end
for j = 1:numel(p)
    mag = mag/sqrt((omega-imag(p(j)))^2+(sigma-real(p(j)))^2);
end
end

