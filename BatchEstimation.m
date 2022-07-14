%%% Batch Estimator
% Estimates the center of gravity position from IMU data. 

% Data from IMU is column Orientated
% [Time, w1, w2, w3, GX, GY, GZ]

filename = 'DATA01.CSV'; % 

data = readtable(filename);
[n_row, n_cols] = size(data);

w = [data.i, data.j, data.k,]; % Angular velocities
g = [data.GX, data.GY, data.GZ];
t = data.Time;

W = zeros(3, 6, n_row);
wCross = zeros(3,3,n_row);
gCross = zeros(3,3,n_row);
Phi = zeros(3*n_row, 9);
oMultW = zeros(3,6,n_row);

for i = 1:n_row

    t_i = t(1:i); % Temp time values array to integrate along

    gCross(:,:,i) = crossop(g(i,:)); % gravity cross up tensor

    w_i = w(i,:); % Temporary angular velocity omega
    wCross_i = crossop(w_i); % Temp omega cross op
    wCross(:,:,i) = wCross_i; % Full omega cross op tensor


    W_i = [w_i(1) 0       0       w_i(2)   w_i(3) 0
           0      w_i(2)  0       w_i(1)   0       w_i(3)
           0      0       w_i(3)  0        w_i(1)  w_i(2)]; % Temp big omega

    W(:,:, i) = W_i; % Full Big omega tensor

    oMultW_i = wCross_i * W_i; % Temp omegaCross Big omega mtx multiplcation
    oMultW(:,:,i) = oMultW_i; % Full matrix multiplcation Tensor

    a1 = W_i + trapz(t_i, oMultW(:,:,1:i), 3); % First element in matrix
    % Omega + integral _t0 ^t (omega X Omega)dt

    a2 = trapz(t_i, gCross(:,:,1:i), 3); % Second element in matrix
    % integral_t0 ^t gCross dt
    phi = [a1 a2];
    rows = (1:3) + 3 * (i - 1); % Row indices. 
    Phi(rows, :) = phi;

end

function vecCross = crossop(vec)
% Converts vector to matrix cross operator
vecCross = [ 0      -vec(3)  vec(2)
             vec(3)  0      -vec(1)
            -vec(2)  vec(1)  0];
end

