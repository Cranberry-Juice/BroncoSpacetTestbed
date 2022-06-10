%% Declares values used in Simulink Main.
% Units: KMS
% Coordinate Frame: World View. X right, Y up, Z out of screen.
% Nomenclature:
% SC: Spacecraft
% CG: Center of Gravity
% CoR: Center of Rotation
% TB: Test Bed
% In.: Inertia
% ABS: Autmatic Balance System

%% Spacecraft Test Aritcle Mass Properties Taken from BS-1 CAD 6/10/22
m_sc = 2.018492; % [kg] Mass of test article.

% Units: g * mm^2
Ixx = 6.105e6;
Iyy = 5.865e6;
Izz = 3.635e6;

Ixy = -1.756e5;
Ixz = -90573.811;

Iyx = Ixy;
Iyz = 59661.642;

Izx = Ixz;
Izy = Iyz;


I_sc = [Ixx Ixy Ixz
        Iyx Iyy Iyz
        Izx Izy Izz] * ((1/1000) * (1/1000)^2); %kg * m^2

I_tb = TBInertia; % In. of Testbed w/o balance masses. Initial guess.

r_off = [-1; 5; -2;] / 100; % cm conv. to meter. Initial CG offest from CoR of SC
R_o = m_sc * r_off; % eq 3 m_total - mb = m_sc
%% Automatic Mass Balance System
% Assuming testbed's CG is alligned with CoR without test article in place.
% Written following Kim and Agrawal
mx = 0.11;         % [kg]
rhox = [0.1 0 0]; % [m]
ux = [1 0 0];      % [unitless]
dx = 0;            % [m]
 
my = 0.11;         % [kg]
rhoy = [0.1 0 0.1]; % [m]
uy = [0 -1 0];      % [unitless] 
dy = 0;            % [m]

mz = 0.11;            % [kg]
rhoz = [0 0 0.1]; % [m]
uz = [0 0 1];         % [unitless]
dz = 0;               % [m]

mb = mx + my + mz; % [kg] Total mass of ABS
m = mb + m_sc; % [kg] Total of mass of ABS + SC
d = [dx dy dz]; % Initial offset of balance masses. Place in vector for
% convinience
miU_mat_inv = inv([mx*ux' my*uy' mz*uz']); %inverse matrix of directional vectors U. See notes


% Alternative Values with manufacturing errors
% rhox_n= rhox + [0.001 0.002 0.003] % [cm]
% rhoy_n= rhox + [0.001 0.002 0.003] % [cm] 
% rhoz_n= rhox + [0.001 0.002 0.003] % [cm]
% ux_n= ux + [0.001 0.002 0.003] % [unitless]
% uy_n= uy + [0.001 0.002 0.003] % [unitless]
% uz_n= uz + [0.001 0.002 0.003] % [unitless] 

stepsz = 1.5e-6; %m Smallest Step size possible for ABS steppers