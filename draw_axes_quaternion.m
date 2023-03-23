function draw_axes_quaternion(vector, quaternion)
% DRAW_AXES: Draw the axes of a body using the provided vector and quaternion.
% The x-axis is red, y-axis is green, and z-axis is blue.
%
% Usage: draw_axes(vector, quaternion)
%
% Inputs:
%   - vector: a 3-element vector representing the position of the body
%   - quaternion: a 1x4 quaternion representing the orientation of the body

% Convert the quaternion to a rotation matrix
rot_matrix = q2rot(quaternion);

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

