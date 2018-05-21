[x,y,z,state] = HW1(eye(3),'rot');

isequal(x,[1 0 0]')
isequal(y,[0 1 0]')
isequal(z,[0 0 1]')
isequal(state,'no')


[x,y,z,state] = HW1([1 0 0; 0 -1 0; 0 0 -1],'rot');

isequal(x,[1 0 0]')
isequal(y,[0 -1 0]')
isequal(z,[0 0 -1]')
isequal(state,'yes')


[x,y,z,state] = HW1([0,0,0],'ZYZ');

isequal(x,[1 0 0]')
isequal(y,[0 1 0]')
isequal(z,[0 0 1]')
isequal(state,'no')

[x,y,z,state] = HW1([pi/2,pi,-pi/2],'ZYZ');
all((x-[1 0 0]')<eps)
all((y-[0 -1 0]')<eps)
all((z-[0 0 -1]')<eps)
isequal(state,'yes')

[x,y,z,state] = HW1([pi,0,0],'rpy');
all((x-[1 0 0]')<eps)
all((y-[0 -1 0]')<eps)
all((z-[0 0 -1]')<eps)
isequal(state,'yes')

[x,y,z,state] = HW1([-pi/2,pi/2,0],'rpy');
all((x-[0 0 -1]')<eps)
all((y-[-1 0 0]')<eps)
all((z-[0 1 0]')<eps)
isequal(state,'no')
