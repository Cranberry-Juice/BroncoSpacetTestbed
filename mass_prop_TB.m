%%%%%%%%%%%%%% Mass Properties of Testbed

% [kg]
m_p    = 1.193; % Plate mass.
m_bear = 0.420; % Bearing mass from bearing spec sheet.

m_i = [0.813     % misc mass 1.
       1.3       % Z mass balance assembly.
       0.696     % misc mass 2.
       1.3       % X mass balance assembly.
       1.3       % Y mass balance assembly.
       m_p       % CM of plate.
       m_bear ]; % CM of bearing.
m_TB = sum(m_i);

%% Position vectors in b.f.f. of non-ABS masses.
% [meters]
r_i = [-0.13111984  0.03         -0.18725853    % misc mass 1.
        0          -0.088530     -0.267740      % Z mass balance assembly.
        0.13470411  0.05         -0.13470411    % misc mass 2.
        0.204432   -0.0304240     0.184972      % X mass balance assembly.
       -0.204008   -0.036000      0.184760      % Y mass balance assembly.
        0           t_p/2         0             % CM of plate.
        0          (-3*r_bear)/8  0         ]'; % CM of bearing.
% Note: Vectors inputted as row but then switch to column orientation.
% Physical vectors are always column oriented by convention.

% Fixes offset error due to previous assumptoin of CoR being at surface of
% plate
offset_fix = 0.00476;
r_i(2,:) = r_i(2,:) + offset_fix;

%% Inertia Calculation

R_p = 7.5/39.37;   % radius of plate. Inches converted to meteres
t_p = 0.25/39.37;  % Thickness of plate. Inches converted to meters.
d_bear = 0.075;    % Diam of bearing measured
r_bear = d_bear/2; % Radius of bearing

