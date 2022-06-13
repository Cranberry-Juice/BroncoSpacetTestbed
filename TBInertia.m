function I = TBInertia
% Roughly estimates the inertia of testbed WITHOUT balance masses. 
% Values are guesses. Serves as starting point to test control algorithm of
% ABS
% Data from excel "ThanosTestBedMassProperties"
r = [-0.13111984   0          -0.18725853
      0           -0.1016002  -0.22860046
      0.13470411  -0.01270003 -0.13470411
      0.152664659 -0.0508001   0.152664659
     -0.16164493  -0.0508001   0.161644933]; 
% m. Position of testbed masses relative to Center of rotation

m = [0.813
     1.65
     0.696
     1.65
     1.65]; % kg

m_p = 1.3;        % Mass of Plate kg
R_p = 7.5/39.37;  % radius of plate. Inches converted to meteres
t_p = 0.25/39.37; %T hickness of plate. Inches converted to meters.

% Inertia Tensor of Cylinder https://en.wikipedia.org/wiki/List_of_moments_of_inertia#:~:text=Solid%20cylinder%20of%20radius%20r%2C%20height%20h%20and%20mass%20m.
Iyy = 0.5 * m_p * R_p^2;
Ixx = (1/12) * m_p * (3 * R_p ^2  + t_p^2 );
Izz = Ixx;

I = [Ixx 0   0
     0   Iyy 0
     0   0   Izz]; % Inertia of flat plate
[nrow, ~] = size(r);

% Inertia Inertia of Each testbed mass.
for i = 1:nrow
    R = crossop(r(i,:));
    tempI = -m(i) * R * R;
    I = I + tempI; 
end



end


function U = crossop(u)
% Rearranges vector into cross productor matrix operator
U = [ 0    -u(3)  u(2)
      u(3)  0    -u(1)
     -u(2)  u(1)  0   ];
end