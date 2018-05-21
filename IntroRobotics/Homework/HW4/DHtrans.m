% sorawit Inprom
% 5/02/2018
% this Function use to find the Homogenous matrix that represent by DH
% parameter

function T = DHtrans(par1,par2,par3,par4)
    T = (rot('z',par1));
    T = T*(trans('z',par2));
    T = T*(trans('x',par3));
    T = T*(rot('x',par4));
end