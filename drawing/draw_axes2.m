function draw_axes2(position, rotation_matrix)
    % Ensure the inputs are valid
    assert(size(position, 1) == 3 && size(position, 2) == 1, 'Position must be a 3x1 vector');
    assert(size(rotation_matrix, 1) == 3 && size(rotation_matrix, 2) == 3, 'Rotation matrix must be a 3x3 matrix');

    % Create a new figure
    figure;
    hold on;
    axis equal;
    grid on;

    % Define the axes' colors and labels
    colors = {'r', 'g', 'b'};
    labels = {'X', 'Y', 'Z'};

    % Define the length of the axes
    axes_length = 1;

    % Iterate through the X, Y, and Z axes
    for i = 1:3
        % Calculate the end point of the current axis
        end_point = position + rotation_matrix(:, i) * axes_length;

        % Draw the current axis
        quiver3(position(1), position(2), position(3), ...
                end_point(1) - position(1), end_point(2) - position(2), end_point(3) - position(3), ...
                colors{i}, 'LineWidth', 2, 'MaxHeadSize', 0.3);

        % Add a label for the current axis
        text(end_point(1), end_point(2), end_point(3), labels{i}, 'FontSize', 14, 'Color', colors{i});
    end

    % Set the axis labels
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    hold off;
end

