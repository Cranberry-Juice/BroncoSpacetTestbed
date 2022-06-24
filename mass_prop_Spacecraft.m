%%%%%% Mass properties of Spacecraft/Test article.
% Mass Properties Taken from BS-1 CAD 6/10/22

m_SC = 2.018492; % [kg]

%% Inertia Properties
% [g * mm^2]
Ixx = 6.105e6;
Iyy = 5.865e6;
Izz = 3.635e6;

Ixy = -1.756e5;
Ixz = -90573.811;

Iyx = Ixy;
Iyz = 59661.642;

Izx = Ixz;
Izy = Iyz;

toKg2m = ((1/1000) * (1/1000)^2); % Conversion factor 

% [kg * m^2]
I_SC = [Ixx Ixy Ixz
        Iyx Iyy Iyz
        Izx Izy Izz] * toKg2m;