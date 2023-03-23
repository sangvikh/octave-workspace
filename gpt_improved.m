% Define constants
CONSTANTS.dt = 0.01;
CONSTANTS.tStart = 0;
CONSTANTS.tEnd = 30;
CONSTANTS.g = [0 0 -9.81];

% Initialize variables
t = CONSTANTS.tStart:abs(CONSTANTS.dt):CONSTANTS.tEnd;
n = length(t);
x = zeros(n, 3);
xDot = zeros(n, 3);
xDotDot = zeros(n, 3);

% Set initial state
x(1,:) = [0 0 1];
xDot(1,:) = [0 0 0];

% Define acceleration function
function acceleration = getAcceleration(x, xDot)
acceleration = - x - 0 * xDot;
end

% Define integrator function
function [x,xDot,dt,i] = leapfrogIntegrator(x,xDot,dt,i, getAcceleration)
% Update velocity (at time = t + 1/2)
xDot(i,:) = xDot(i,:) + getAcceleration(x(i,:), xDot(i,:)) * dt/2;

% Update position (at time = t + 1)
x(i+1,:) = x(i,:) + xDot(i,:) * dt;

% Update velocity (at time = t + 3/2)
xDot(i+1,:) = xDot(i,:) + getAcceleration(x(i+1,:), xDot(i+1,:)) * dt/2;
end

% Integrate using leapfrog
for i = 1:(n-1)
[x, xDot, CONSTANTS.dt, i] = leapfrogIntegrator(x, xDot, CONSTANTS.dt, i, @getAcceleration);
end

% Plot the result
plot(t, x(:,3));
title('Z Position over time');
xlabel('Time (s)');
ylabel('Position (m)');

% Add grid and labels
grid on;
hold on;
