%% Declares values used in Simulink Main.
% Units: KMS
% Coordinate Frame: World View. X right, Y up, Z out of screen.
% Nomenclature:
% SC: Spacecraft
% CG: Center of Gravity
% CoR: Center of Rotation
% TB: Test Bed
% In.: Inertia
% ABS: Automatic Balance System

%% Options
use_thanos_properties = true; % Uses thanos testbed properties and geometry
test_article_loaded = false; % Adds test article mass properties.

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

r_off = [-1; 5; -2;] / 100; % cm conv. to meter. Initial CG offest from CoR of SC
CM_sc_nonNorm = m_sc * r_off; % eq 3 m_total - mb = m_sc. Not "Normalized, must divide by total system masss for true CM.


%% Test Bed Mass Properties
% Roughly estimates the inertia of testbed WITHOUT balance masses. 
% Values are guesses. Serves as starting point to test control algorithm of
% ABS
% Data from excel "ThanosTestBedMassProperties"
r_i = [-0.13111984   0          -0.18725853
        0           -0.1016002  -0.22860046
        0.13470411  -0.01270003 -0.13470411
        0.152664659 -0.0508001   0.152664659
       -0.16164493  -0.0508001   0.161644933]; 
% m. Position of testbed masses relative to Center of rotation

m_i = [0.813
       1.75
       0.696
       1.75
       1.75]; % kg


m_p = 1.193;      % Mass of Plate kg
R_p = 7.5/39.37;  % radius of plate. Inches converted to meteres
t_p = 0.25/39.37; % Thickness of plate. Inches converted to meters.

m_tb = sum(m_i) + m_p;

% Inertia Tensor of Cylinder https://en.wikipedia.org/wiki/List_of_moments_of_inertia#:~:text=Solid%20cylinder%20of%20radius%20r%2C%20height%20h%20and%20mass%20m.
Iyy = 0.5 * m_p * R_p^2;
Ixx = (1/12) * m_p * (3 * R_p ^2  + t_p^2 );
Izz = Ixx;

I_tb = [Ixx 0   0
        0   Iyy 0
        0   0   Izz]; % Inertia of flat plate
[nrow, ~] = size(r_i);

% Inertia Inertia of Each testbed mass.
for i = 1:nrow
    R = crossop(r_i(i,:));
    tempI = -m_i(i) * R * R;
    I_tb = I_tb + tempI; % Total inertia of testbed.
end

% CM TestBed W/o balance masses
% Prep for simple matrix operations
r_i = r_i'; % Vectors are now column oriented
m_i = diag(m_i); %

% CM = 1/m * SUM(m_i_scalar * R_i_vector)
CM_tb_nonNorm = sum(r_i * m_i, 2); % Vector position of Testbed CoM
% Not "Normalized" Must divide by total mass of system for true CM. TBD by
% simulation

%% Thanos Mass Balance System


if use_thanos_properties
    m_balance = 0.4; % Kg
    m_mat = diag([m_balance m_balance m_balance]);
    m_tot_bal = sum(m_mat, 'all');
    u1 = [0 -1 0]';
    u2 = [1 0 -1]';
    u3 = [-1 0 -1]';
    u1 = u1/norm(u1);
    u2 = u2/norm(u2);
    u3 = u3/norm(u3);

    u_mat = [u1 u2 u3];
    mU = inv(u_mat * m_mat);

    %Initial offsets from starting position
    d1 = 0;
    d2 = 0;
    d3 = 0;

    % Starting position rho
    rho1 = [ 0           -0.050800102  -0.279400559]'  + d1 * u1;
    rho2 = [ 0.19756603  -0.050800102   0.19756603]' + d2 * u2;
    rho3 = [-0.188585756 -0.050800102   0.188585756]' + d3 * u3;
    Rho_i = [rho1 rho2 rho3];
    CM_bm_nonNorm = sum(Rho_i * m_mat, 2);

else % Use new ABS properties
    m_balance = 0.8; % Kg
    m_mat = diag([m_balance m_balance m_balance]);
    m_tot_bal = sum(m_mat, 'all');
    u1 = [1  0 0]';
    u2 = [0 -1 0]';
    u3 = [0  0 1]';
    u1 = u1/norm(u1);
    u2 = u2/norm(u2);
    u3 = u3/norm(u3);

    u_mat = [u1 u2 u3];
    mU = inv(u_mat * m_mat);
    
    %Initial offsets from starting positions
    d1 = 0;
    d2 = 0;
    d3 = 0;
    
    %Starting position rho
    rho1 = [0.1 0 0]' + d1 * u1;
    rho2 = [0.1 0 0.1]' + d2 * u2;
    rho3 = [0   0 0.1]' + d3 * u3;
    Rho_i = [rho1 rho2 rho3];
    CM_bm_nonNorm = sum(Rho_i * m_mat, 2);
end

%% Optionally run sim with testbed only or testbed + test article

if test_article_loaded
    M_TOT = m_sc + m_tot_bal + m_tb;
    r_cm_0 = CM_bm_nonNorm + CM_sc_nonNorm + CM_bm_nonNorm / M_TOT;
else
    M_TOT = m_tot_bal + m_tb;
    r_cm_0 = CM_bm_nonNorm + CM_bm_nonNorm / M_TOT;
end

%% Other values

stepsz = 5e-6; % m Smallest Step size possible for ABS steppers
 

function U = crossop(u)
% Rearranges vector into cross productor matrix operator
U = [ 0    -u(3)  u(2)
      u(3)  0    -u(1)
     -u(2)  u(1)  0   ];
end