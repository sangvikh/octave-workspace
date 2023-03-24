function draw_axes(vector, rot_matrix)
% DRAW_AXES: Draw the axes of a body using the provided vector and rotation matrix.
% The x-axis is red, y-axis is green, and z-axis is blue.
%
% Usage: draw_axes(vector, rot_matrix)
%
% Inputs:
%   - vector: a 3-element vector representing the position of the body
%   - rot_matrix: a 3x3 rotation matrix representing the orientation of the body

% Define the axes positions
x_axis = [vector; vector + rot_matrix(:,1)'];
y_axis = [vector; vector + rot_matrix(:,2)'];
z_axis = [vector; vector + rot_matrix(:,3)'];

% Draw the axes
hold on
plot3(x_axis(:,1), x_axis(:,2), x_axis(:,3), 'r-', 'LineWidth', 2)
plot3(y_axis(:,1), y_axis(:,2), y_axis(:,3), 'g-', 'LineWidth', 2)
plot3(z_axis(:,1), z_axis(:,2), z_axis(:,3), 'b-', 'LineWidth', 2)
hold off

% Set the plot properties
axis equal
grid on
xlabel('x')
ylabel('y')
zlabel('z')
title('Body Axes')
end


