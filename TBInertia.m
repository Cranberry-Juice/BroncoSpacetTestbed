function I_tb = TBInertia
% Roughly estimates the inertia of testbed. 
% Values are guesses. Serves as starting point to test control algorithm of
% ABS
r = [0       0.1   0.1  -0.1  -0.1
     -0.05  -0.1   0     0     0.02
     -0.1    0.02  0.1   0.1  -0.1]; % m. Position of balances masses on test bed

m = [0.5 0.7 0.5 0.5 0.7]; % kg
m_p = 5; % Mass of Plate
R_p = 0.15; % m
I_pxx = 0.5 * m_p * R_p ^2;

I_p = [I_pxx 0       0
       0     2*I_pxx 0
       0     0       I_pxx]; % Inertia of circular plate
I = zeros(3,3);
for i = 1:5
    R = crossop(r(:,1));
    tempI = -m(i) * R * R;
    I = I + tempI; 
end

I_tb = I + I_p;

end


function U = crossop(u)
U = [ 0    -u(3)  u(2)
      u(3)  0    -u(1)
     -u(2)  u(1)  0   ];
end