clf
pkg load quaternion
% Define the vector and rotation matrix
vector = [0 0 0];
rot_matrix = [0 1 0; -1 0 0; 0 0 1];

% Draw the axes
draw_axes(vector, rot_matrix)
hold on;

% Define the vector and rotation matrix
vector = [10 10 10];
rot_matrix = [1/2 -sqrt(3)/2 0; sqrt(3)/2 1/2 0; 0 0 1];

% Draw the axes
draw_axes(vector, rot_matrix)
hold on;

