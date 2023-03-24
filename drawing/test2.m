position = [1 2 3];
rotation_matrix = eye(3); % Identity matrix for no rotation
draw_axes(position, rotation_matrix);

position = [4 5 6];
rotation_matrix = rotz(45)*rotx(45);
draw_axes(position, rotation_matrix);

