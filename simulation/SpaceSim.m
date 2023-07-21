% Constants
dt = 0.01;
tStart = 0;
tEnd = 60;
t = tStart:dt:tEnd;
g = [0 0 -9.81];

% Initialize vectors
x = zeros(length(t),3);
xDot = zeros(length(t),3);
xDotDot = zeros(length(t),3);
y = zeros(length(t),3);
yDot = zeros(length(t),3);
yDotDot = zeros(length(t),3);

% Initial state
x(1,:) = [0 0 0];
xDot(1,:) = [0 0 0];

y(1,:) = [1 0 0];
yDot(1,:) = [0 2 0];

% Integrator
i = 1;
while t(i) < t(end)
  % Current xDotDot
  xDotDot(i,:) = -(x(i,:) - y(i,:))/(norm(x(i,:) - y(i,:))^2 + 1e-9)*0;
  yDotDot(i,:) = -(y(i,:) - x(i,:))/(norm(y(i,:) - x(i,:)) + 1e-9);

  %Integrate
  xDot(i+1,:) = xDot(i,:) + xDotDot(i,:)*dt;
  x(i+1,:) = x(i,:) + xDot(i,:)*dt + 0.5*xDotDot(i,:)*dt*dt;

  yDot(i+1,:) = yDot(i,:) + yDotDot(i,:)*dt;
  y(i+1,:) = y(i,:) + yDot(i,:)*dt + 0.5*yDotDot(i,:)*dt*dt;

  % Index variable
  i = i + 1;
end

%figure;
grid on;
hold on;
plot(t,x(:,3));
%plot(t,xDot(:,3));
%plot(t,xDotDot(:,3));
%plot3(x(:,1),x(:,2),x(:,3));
%plot3(y(:,1),y(:,2),y(:,3));
%x(end,3)
