% Constants
G = 6.674e-11;      % Gravitational constant
M = 5.97e24;        % Mass of Earth
R = 6378.137e3;     % Radius of Earth

% Initial conditions
x0 = R + 1000e3;    % Initial x position (m)
y0 = 0;             % Initial y position (m)
vx0 = 0;            % Initial x velocity (m/s)
vy0 = 7.8e3;        % Initial y velocity (m/s)

% Simulation parameters
t0 = 0;             % Initial time (s)
tf = 2*pi*sqrt(x0^3/(G*M));   % Final time (s)
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

% Numerical integration with Runge-Kutta method
for i = 1:n-1
    % Calculate acceleration
    r = sqrt(x(i)^2 + y(i)^2);
    ax = -G*M*x(i)/r^3;
    ay = -G*M*y(i)/r^3;

    % Calculate k1, k2, k3, k4
    k1x = vx(i);
    k1y = vy(i);
    k1vx = ax;
    k1vy = ay;

    k2x = vx(i) + k1vx*dt/2;
    k2y = vy(i) + k1vy*dt/2;
    k2vx = -G*M*x(i)/r^3*dt/2;
    k2vy = -G*M*y(i)/r^3*dt/2;

    k3x = vx(i) + k2vx*dt/2;
    k3y = vy(i) + k2vy*dt/2;
    k3vx = -G*M*x(i)/r^3*dt/2;
    k3vy = -G*M*y(i)/r^3*dt/2;

    k4x = vx(i) + k3vx*dt;
    k4y = vy(i) + k3vy*dt;
    k4vx = -G*M*x(i)/r^3*dt;
    k4vy = -G*M*y(i)/r^3*dt;

    % Update position and velocity
    x(i+1) = x(i) + (k1x + 2*k2x + 2*k3x + k4x)*dt/6;
    y(i+1) = y(i) + (k1y + 2*k2y + 2*k3y + k4y)*dt/6;
    vx(i+1) = vx(i) + (k1vx + 2*k2vx + 2*k3vx + k4vx)*dt/6;
    vy(i+1) = vy(i) + (k1vy + 2*k2vy + 2*k3vy + k4vy)*dt/6;
end

% Plot the orbit
figure
plot(x,y)
axis equal

