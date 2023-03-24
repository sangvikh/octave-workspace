clc;clear all;close all;

% Setup
dt = 0.5;
tStart = 0;
tEnd = 10;
t = tStart:dt:tEnd;
g = [0 0 -9.81];

% Initial state
x(1,:) = [0 0 0];
xDot(1,:) = [0 0 0];
xDotDot(1,:) = [0 0 0];

% Integrator
i = 0;
while t(i+1) < tEnd
  % Iterator
  i = i + 1;

  % Current xDotDot
  xDotDot(i+1,:) = g;

  %Integrate
  xDot(i+1,:) = xDot(i,:) + xDotDot(i,:)*dt;
  x(i+1,:) = x(i,:) + xDot(i,:)*dt + 0*0.5*xDotDot(i,:)*dt*dt;
end

figure;
grid on;
hold on;
%plot(t,x(:,3));
%plot(t,xDot(:,3));
%plot(t,xDotDot(:,3));
plot3(x(:,1),x(:,2),x(:,3));
x(end,3)
