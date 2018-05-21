%car
vehical_length = 0.365;
vehical_width = 0.2;
distance_of_CG = vehical_length/2;

%initial position
x_init = 0;
y_init = 1;
psi_init = deg2rad(60);

%select test case curve
% 0 --> vertical x = x_intersept
% 1 --> horizontal y = y_intersept
% 2 --> linear curve
% 3 --> parabola curve
% 4 --> Circular curve
test_case = 2;

%initial vertical
x_intersept = 0;

%initial horizontal
y_intersept = 0;

%initial linear curve
x0 = 0;
y0 = 0;
Theta = 45; %(deg)

%initial parabola curve
parabora_coefficient = 0.2;

%Turn left
translation = [x_init ; y_init];
Radius = 0.8;
Center_R = [0 ; +Radius]; % left(+) right(-)
rotationR2G = [cos(psi_init) -sin(psi_init) ; sin(psi_init) cos(psi_init)];
Center_G = rotationR2G*Center_R + translation;
H = Center_G(1);
K = Center_G(2);




