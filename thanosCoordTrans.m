%% Coordinate transform from Old thanos coordinates to new coordinate system
% Refer to notes.
a = deg2rad(135);
nintey = deg2rad(90);
X_n = [1 0 0
       0 0 1
       0 -1 0];
X_o = [cos(a)          sin(a)          0
       cos(a + nintey) sin(a + nintey) 0
       0               0              1];
C = zeros(3,3);
for i = 1:3
    for j= 1:3
        C(i,j) = dot(X_n(i,:), X_o(j,:));
%         C(i,j) = j;
    end
end
disp(C)