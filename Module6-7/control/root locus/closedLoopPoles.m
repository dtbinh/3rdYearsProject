%Sorrawit Inprom, 7/11/2017, This is function calculates the location 
%of closed-loop poles which return 2 output (sigma = real part of 
%closed-loop poles , omega = imaginary part of closed-loop poles)

function [sigma,omega] = closedLoopPoles(z,p,spec,value, guess)

if strcmp(spec,'OS') % percent overshoot
    OS = value;
    zeta = -log(OS)/sqrt(pi^2+log(OS)^2);
    fun = @(w_n)cos(sumAngle(-zeta*w_n,w_n*sqrt(1-zeta^2),z,p))+1;
    options = optimoptions('fsolve');
    options.FunctionTolerance = 1e-12;
    options.OptimalityTolerance = 1e-12;
    w_n = fsolve(fun,guess,options);
    sigma = -zeta*w_n;
    omega = w_n*sqrt(1-zeta^2);
    
elseif strcmp(spec,'Ts')% settling time
    Ts = value;
    fun = @(w)cos(sumAngle(-4/Ts,w,z,p))+1;
    options = optimoptions('fsolve');
    options.FunctionTolerance = 1e-12;
    options.OptimalityTolerance = 1e-12;
    w = fsolve(fun,guess,options);
    sigma = -4/Ts;
    omega = w;
    
elseif strcmp(spec,'Tp') % peak time
    Tp = value;
    fun = @(s)cos(sumAngle(s,pi/Tp,z,p))+1;
    options = optimoptions('fsolve');
    options.FunctionTolerance = 1e-12;
    options.OptimalityTolerance = 1e-12;
    s = fsolve(fun,guess,options);
    sigma = s;
    omega = pi/Tp;
else
    error('undefined specification')
end



end