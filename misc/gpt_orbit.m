% Constants
G = 6.674e-11;      % Gravitational constant
M = 5.97e24;        % Mass of Earth
R = 6378.137e3;     % Radius of Earth

% Initial conditions
x0 = R + 1000e3;    % Initial x position (m)
y0 = 0;             % Initial y position (m)
vx0 = 0;            % Initial x velocity (m/s)
vy0 = 7.8e3+2500;        % Initial y velocity (m/s)

% Simulation parameters
t0 = 0;             % Initial time (s)
tf = 3600*24*7;     % Final time (s)
dt = 10;            % Time step (s)

% Preallocate arrays
t = t0:dt:tf;
n = length(t);
x = zeros(1,n);
y = zeros(1,n);
vx = zeros(1,n);
vy = zeros(1,n);

% Set initial values
x(1) = x0;
y(1) = y0;
vx(1) = vx0;
vy(1) = vy0;

% Numerical integration with Implicit Euler method
for i = 1:n-1
    % Calculate acceleration
    r = sqrt(x(i)^2 + y(i)^2);
    ax = -G*M*x(i)/r^3;
    ay = -G*M*y(i)/r^3;

    % Update velocity
    vx(i+1) = vx(i) + ax*dt;
    vy(i+1) = vy(i) + ay*dt;

    % Update position
    x(i+1) = x(i) + vx(i+1)*dt;
    y(i+1) = y(i) + vy(i+1)*dt;
end

% Plot the orbit
figure
plot(x,y)
axis equal

