clc; clear all; close all;

% Function
f = @(x)  x.^2 - 0.0;
f = @(x)   -0.1*x.^3 + 10*x - 4;
% Numerical derivative
h = 1e-9;
fd = @(x)  (f(x + h) - f(x)) / h;
fdd = @(x) (d(x + h) - d(x)) / h;

x = -15:0.1:15;
y = f(x);

figure
hold on
grid on
plot(x, y, 'linewidth', 2)

% Newton rhapson iterations
% x1 = x0 - f(x)/f'(x)
clear x;
% Initial guess
x(1) = 5;
% Number of iterations
n = 10;
alpha = 1;

xplot = 0;
yplot = 0;
for i = 1:n-1
  x(i+1) = x(i) - alpha*f(x(i))/fd(x(i));

  xplot(2*i-1) = x(i);
  xplot(2*i)   = x(i);

  yplot(2*i-1) = 0;
  yplot(2*i)   = f(x(i));
end
%yplot(1) = f(x(1))

plot(xplot, yplot, 'linewidth', 2)
figure
hold on
grid on
plot(x)
