%% Declares values used in Simulink Main.
% Units: KMS
% Coordinate Frame NED
% Nomenclature:
% SC: Spacecraft
% CG: Center of Gravity
% CoR: Center of Rotation
% TB: Test Bed
% In.: Inertia
% ABS: Autmatic Balance System
m_sc = 6; % [kg] Mass of test article.
I_sc = [130.34 3.01 10.52
        3.02 174.64 -0.4
        10.52 -0.4 181.23]; % In. of Spacecraft. Initial Guess

I_tb = [1 0.1 0.1
        0.1 1 0.1
        0.1 0.1 1]; % In. of Testbed w/o balance masses. Initial guess.

r_off = [-1 -2 -5] / 100; % cm conv. to meter. Initial CG offest from CoR of SC
R_o = m_sc * r_off; % eq 3 m_total - mb = m_sc
%% Automatic Mass Balance System
% Assuming testbed's CG is alligned with CoR without test article in place.
% Written following Kim and Agrawal
mx = 0.11;         % [kg]
rhox = [0.05 0 0]; % [m]
ux = [1 0 0];      % [unitless]
dx = 0;            % [m]

my = 0.11;         % [kg]
rhoy = [0 0.05 0]; % [m]
uy = [0 1 0];      % [unitless] 
dy = 0;            % [m]

mz = 0.11;            % [kg]
rhoz = [0.05 0.05 0]; % [m]
uz = [0 0 1];         % [unitless]
dz = 0;               % [m]

mb = mx + my + mz; % [kg] Total mass of ABS
m = mb + m_sc; % [kg] Total of mass of ABS + SC
d = [dx dy dz]; % Initial offset of balance masses. Place in vector for
% convinience

% Alternative Values with manufacturing errors
% rhox_n= rhox + [0.001 0.002 0.003] % [cm]
% rhoy_n= rhox + [0.001 0.002 0.003] % [cm] 
% rhoz_n= rhox + [0.001 0.002 0.003] % [cm]
% ux_n= ux + [0.001 0.002 0.003] % [unitless]
% uy_n= uy + [0.001 0.002 0.003] % [unitless]
% uz_n= uz + [0.001 0.002 0.003] % [unitless] 
