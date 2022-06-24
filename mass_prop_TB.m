%% Mass Properties of Testbed

% [kg]
m_p    = 1.193; % Plate mass.
m_bear = 0.420; % Bearing mass from bearing spec sheet.

% Position vectors in b.f.f. of non-ABS masses.
% [meters]
r_i = [-0.13111984  0.03 +  0.00476            -0.18725853   % misc mass 1.
        0          -0.088530+  0.00476        -0.267740      % Z mass balance assembly.
        0.13470411  0.05 +  0.00476     -0.13470411          % misc mass 2.
        0.204432   -0.0304240 +  0.00476       0.184972      % X mass balance assembly.
       -0.204008   -0.036000 +  0.00476        0.184760      % Y mass balance assembly.
        0           t_p/2   +  0.00476         0             % CM of plate.
        0          (-3*r_bear)/8 +  0.00476    0         ]'; % CM of bearing.
% Note: Vectors inputted as row but then switch to column orientation.
% Physical vectors are always column oriented by convention.

% Corresponding masses.  
% [kg]
m_i = [0.813
       1.3
       0.696
       1.3
       1.3
       m_p
       m_bear ]; 
m_tb = sum(m_i);