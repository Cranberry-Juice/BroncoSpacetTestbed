%%% Mass verifcation testbed Mass properties
% Mass
% [grams]
m_i = [1228 % plate
       0.5  % Bearing screw 1
       0.5  % Bearing screw 2
       0.5  % Bearing screw 3
       0.5  % Bearing screw 4
       0.5  % Bearing screw 5
       0.5  % Bearing screw 6
       0.5  % Bearing screw 7
       0.5  % Bearing screw 8
       209  % bearing
       76   % Arm A
       2    % Bolt A1
       2    % Bolt A2
       1/3  % Nut A1
       1/3  % Nut A2
       75   % Arm B
       2    % Bolt B1
       2    % Bolt B2
       1/3  % Nut B1
       1/3  % Nut B2
       134  % Arm C
       2    % Bolt C1
       2    % Bolt C2
       1/3  % Nut C1
       1/3  % Nut C2
       37   % Battery pack
       7    % Feather Logger
       2    % IMU
       39   % Bread Board
       1.5  % Connector
       ] / 1000; % Converted KG

m_TB = sum(m_i);

r_i = [ 0	         2.32	         0
        0	        -4.6875	         0
        30.82	     1.6685	         0
        21.793031	 1.6685	        -21.793031
        1.88795E-15	 1.6685	        -30.82
       -21.793031	 1.6685	        -21.793031
       -30.82	     1.6685	         0
       -21.793031	 1.6685	         21.793031
       -5.66386E-15	 1.6685	         30.82
        21.793031	 1.6685      	 21.793031
       -77.34678244	 4.64	        -110.4626532
       -89.9774096	 1.745	        -107.2309011
       -124.7308523	 1.745	        -108.4268757
       -89.9774096	-1.610833333	-107.2309011
       -124.7308523	-1.610833333	-108.4268757
       -109.5489912	 4.64	         75.51
       -106.9857669	 1.745	         89.77171757
       -106.1049507	 1.745	         126.4509562
       -106.9857669	-1.610833333	 89.77171757
       -106.1049507	-1.610833333	 126.4509562
        134.140664	 4.64	         23.65261828
        139.5170675	 1.745	         12.20616177
        164.6211739  1.745	        -14.40248649
        139.5170675	-1.610833333	 12.20616177
        164.6211739	-1.610833333	-14.40248649
       -50.87	     3.87	         48.6
       -61.15	     14.72	        -23.05
        0.355	     1.6425	         1.345
       -58.975	     4.67	        -41.14
       -41.01219331	 17.82	        -31
        ] /1000; % Converted to meters


% CM TestBed W/o balance masses
% Prep for simple matrix operations
r_i = r_i'; % Vectors are now column oriented
m_i = diag(m_i); %

% CM = 1/m * SUM(m_i_scalar * R_i_vector)
CM_tb_nonNorm = sum(r_i * m_i, 2); % Vector position of Testbed CoM
% Not "Normalized" Must divide by total mass of system for true CM. TBD by
% simulation
Cm_tb = CM_tb_nonNorm/m_TB
