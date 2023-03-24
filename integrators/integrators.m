% Constants
dt = 0.05;
tStart = 0;
tEnd = 300;
t = tStart:abs(dt):tEnd;
g = [0 0 -9.81];

% Initialize vectors
x = zeros(length(t),3);
xDot = zeros(length(t),3);
xDotDot = zeros(length(t),3);

% Initial state
x(1,:) = [0 0 1];
xDot(1,:) = [1 0 1];

% Acceleration function
function f = f(x = 0, xDot = 0, t = 0)
  f = - x - 0.0*xDot;
end

% Add external forces outside this acceleration function

% Leapfrog integration (kick-drift-kick)
function [x,xDot,dt,i] = leapfrog_kdk(x,xDot,dt,i)
  % Update xDot (at time = t + 1/2)
  xDot(i,:) = xDot(i,:) + f(x(i,:),xDot(i,:)) * dt/2;

  % Update position (at time = t + 1)
  x(i+1,:) = x(i,:) + xDot(i,:) * dt;

  % Update xDot (at time = t + 3/2)
  xDot(i+1,:)= xDot(i,:) + f(x(i+1,:),xDot(i+1,:)) * dt/2;
end

function [x,xDot,dt,i] = euler(x,xDot,dt,i)
  % Acceleration
  xDotDot(i,:) = f(x(i,:),xDot(i,:));

  % Integration (semi implicit euler fwd)
  xDot(i+1,:) = xDot(i,:) + xDotDot(i,:)*dt;
  x(i+1,:) = x(i,:) + xDot(i+1,:)*dt;
end

% Integrate using euler
i = 1;
while t(i) < t(end)
  % Integrator
  %[x,xDot,dt,i] = leapfrog_kdk(x,xDot,dt,i);
  [x,xDot,dt,i] = euler(x,xDot,dt,i);

  % Increment index variable
  i = i + 1;
end

%figure;
grid on;
hold on;
plot(t,x(:,3));

% Integrate using leapfrog_kdk
i = 1;
% Initialize state again
x = zeros(length(t),3);
xDot = zeros(length(t),3);
xDotDot = zeros(length(t),3);
x(1,:) = [0 0 1];
xDot(1,:) = [1 0 1];
while t(i) < t(end)
  % Integrator
  [x,xDot,dt,i] = leapfrog_kdk(x,xDot,dt,i);
  %[x,xDot,dt,i] = euler(x,xDot,dt,i);

  % Increment index variable
  i = i + 1;
end

%figure;
grid on;
hold on;
plot(t,x(:,3));

%figure
%plot3(x(:,1),x(:,2),x(:,3))
