pkg load control;
% Parameters
sampling_time = 0.01; % Sampling time, 0.01 seconds (10 ms)

% State transition matrix (A)
A = [eye(3)   sampling_time*eye(3) zeros(3)   zeros(3)
     zeros(3) eye(3)               zeros(3)   zeros(3)
     zeros(3) zeros(3)             eye(3)     sampling_time*eye(3)
     zeros(3) zeros(3)             zeros(3)   eye(3)];

% Input matrix (B)
B = [0.5*sampling_time^2*eye(3) zeros(3)
     sampling_time*eye(3)       zeros(3)
     zeros(3)                   sampling_time*eye(3)
     zeros(3)                   zeros(3)];

% Output matrix (C)
C = [zeros(3) zeros(3) zeros(3) eye(3)
     zeros(3) zeros(3) eye(3)   zeros(3)];

% No direct transmission from input to output (D)
D = zeros(6, 6);

% Create state-space model
imu_ss = ss(A, B, C, D, sampling_time);

% Initial state
t = 0:sampling_time:5;
n = length(t);
x0 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0]; % [px, py, pz, vx, vy, vz, roll, pitch, yaw, wx, wy, wz]'

% IMU input (measured acceleration and angular velocities)
u = repmat([1; 1; 1; 0.1; 0.1; 0.1],1,6); % [ax, ay, az, wx, wy, wz]'
%t = []

% Simulate IMU for 5 seconds
[y, t, x] = lsim(imu_ss, u, t, x0);

% Plot results
figure;

subplot(3, 1, 1);
plot(t, x(:, 1:3));
xlabel('Time (s)');
ylabel('Position (m)');
legend('x', 'y', 'z');
title('Position');

subplot(3, 1, 2);
plot(t, x(:, 4:6));
xlabel('Time (s)');
ylabel('Velocity (m/s)');
legend('Vx', 'Vy', 'Vz');
title('Velocity');

subplot(3, 1, 3);
plot(t, x(:, 7:9));
xlabel('Time (s)');
ylabel('Orientation (rad)');
legend('Roll', 'Pitch', 'Yaw');
title('Orientation');

