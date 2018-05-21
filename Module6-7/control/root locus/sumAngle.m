%Sorrawit Inprom, 7/11/2017, This is function calculates angle of
%closed-loop poles
function ang = sumAngle(sigma,omega,z,p)
ang = 0;   
for i = 1:numel(z)
    ang = ang + atan2(omega-imag(z(i)),sigma-real(z(i)));
end
for j = 1:numel(p)
    ang = ang - atan2(omega-imag(p(j)),sigma-real(p(j)));
end
end
