% Define the initial conditions
t0 = 0;                 % Initial time
tf = 10;                % Final time
dt = 0.01;              % Time step
tspan = t0:dt:tf;       % Time vector
x0 = [0 0 0];           % Initial position in x, y, and z
v0 = [0 0 0];           % Initial velocity in x, y, and z
q0 = [1 0 0 0];         % Initial quaternion (no rotation)
w0 = [0 0 0];           % Initial angular velocity
y0 = [x0 v0 q0 w0];     % Initial state vector

% Define the parameters of the rigid body
m = 1;                  % Mass
J = eye(3);             % Inertia matrix
I = [m*eye(3) zeros(3); zeros(3) J]; % Inertia tensor
g = [0 0 9.81];         % Gravitational acceleration
L = [0 0 0]';           % External force
M = [0 0 0]';           % External torque

% Define the function for the state derivative
f = @(t, y) [y(4:6); -g + 1/m*quatrotate(y(7:10)', L')' + quatrotate(y(7:10)', [0 0 m*g])'; 1/2*quatmultiply(y(7:10)', [0 y(11:13)])'; I\(M' - skew(y(11:13))*I*y(11:13)')];

% Integrate the equations of motion
[t, y] = ode45(f, tspan, y0);

% Create an instance of the world
myWorld = struct('time', t, 'position', y(:, 1:3), 'velocity', y(:, 4:6), 'quaternion', y(:, 7:10), 'angular_velocity', y(:, 11:13));

% Plot the results
figure;
plot3(y(:, 1), y(:, 2), y(:, 3));
xlabel('x');
ylabel('y');
zlabel('z');
grid on;

