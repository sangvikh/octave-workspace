% Constants
dt = 0.01;
tStart = 0;
tEnd = 30;
t = tStart:abs(dt):tEnd;
g = [0 0 -9.81];

% Initialize vectors
x = zeros(length(t),3);
xDot = zeros(length(t),3);
xDotDot = zeros(length(t),3);

% Initial state
x(1,:) = [0 0 1];
xDot(1,:) = [0 0 0];

% Acceleration function
function f = f(x, xDot = 0)
  f = - x - 0.75*xDot;
end

% Leapfrog integration
function [x,xDot,dt,i] = leapfrog(x,xDot,dt,i)
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

  % Integration (euler fwd)
  x(i+1,:) = x(i,:) + xDot(i,:)*dt;
  xDot(i+1,:) = xDot(i,:) + xDotDot(i,:)*dt;
end

% Integrator
i = 1;
while t(i) < t(end)
  % Integrator
  [x,xDot,dt,i] = leapfrog(x,xDot,dt,i);
  %[x,xDot,dt,i] = euler(x,xDot,dt,i);

  % Increment index variable
  i = i + 1;
end

%figure;
grid on;
hold on;
plot(t,x(:,3));
%plot(t,xDot(:,3));
%plot(t,xDotDot(:,3));
%plot3(x(:,1),x(:,2),x(:,3));
%x(end,3)
