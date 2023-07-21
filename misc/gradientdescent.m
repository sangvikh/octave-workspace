clc; clear all; close all;

% Function
% f(x) = y = x^2 - 4
% f'(x) = y' = 2x

f = @(x)   -0.1*x.^3 + 10*x - 4;
fd = @(x)  -0.3*x.^2 + 10;
fdd = @(x) -0.6*x;
d = @(x) (f(x) - f(x + 0.001)) / 0.001;

x = -15:0.1:15;
y = f(x);
yd = fd(x);

figure
hold on
grid on
plot(x, y, 'linewidth', 2)

% First newton rhapson iteration
% x1 = x0 - f'(x)/f(x)
x0 = 5;
x1 = x0 - f(x0)/fd(x0)
x2 = x1 - f(x1)/fd(x1)
x3 = x2 - f(x2)/fd(x2)
x4 = x3 - f(x3)/fd(x3)
x5 = x4 - f(x4)/fd(x4)
plot([x0    x1    x1    x2    x2    x3    x3    x4    x4    x5    x5],...
     [f(x0) 0     f(x1) 0     f(x2) 0     f(x3) 0     f(x4) 0     f(x5)],...
      'linewidth', 2)
