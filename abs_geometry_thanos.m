%% Geometry of Thanos 

% Direction vectors of mass balance arms.
u1 = [0 1 0]';
u2 = [1 0 -1]';
u3 = [1 0 1]';
u1 = u1/norm(u1);
u2 = u2/norm(u2);
u3 = u3/norm(u3);

%Initial offsets from starting position
d1 = 0;
d2 = 0;
d3 = 0;
d_init = [d1 d2 d3]; 

% Initial position of masses on moving rod
% Starting position rho
rho1 = [ 0          -0.088530 +  0.00476       -0.267740 ]'  + d1 * u1;
rho2 = [ 0.204432   -0.0304240  +  0.00476      0.184972 ]' + d2 * u2;
rho3 = [-0.204008   -0.036000  +  0.00476       0.184760]' + d3 * u3;
Rho_init = [rho1 rho2 rho3];