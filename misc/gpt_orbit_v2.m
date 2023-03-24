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
dt = 60;            % Time step (s)

% Preallocate matrix
n = ceil((tf-t0)/dt) + 1;
state = zeros(n,4);

% Set initial state
state(1,:) = [x0 y0 vx0 vy0];

% Numerical integration with Implicit Euler method
for i = 1:n-1
    % Calculate acceleration
    r = norm(state(i,1:2));
    a = -G*M/r^3 * state(i,1:2);

    % Update velocity and position
    state(i+1,3:4) = state(i,3:4) + a*dt;
    state(i+1,1:2) = state(i,1:2) + state(i+1,3:4)*dt;
end

% Plot the orbit
figure
plot(state(:,1),state(:,2))
axis equal

