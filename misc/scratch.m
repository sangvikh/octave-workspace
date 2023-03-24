clc; clear all; close all;

%Constants
m = 70;
g = 9.81;
b1 = 12.9566;
b2 = 7*b1;
b = b1;         %Initialize b

%Initial data
h0 = 3000;      %Initial height
h = h0;         %Initialize h
hDot0 = 0;      %Initial velocity
hDot = hDot0;   %Initializes hDot
hDotDot = 0;    %Initialize hDotDot (For saving last values etc)
T = 40;         %Parachute opening time
cond = 0;       %Condition flag for setting new initial conditions at t = T

t1 = linspace(0,40,500);
t2 = linspace(40,200,500);

ha = h0 + (m.^2*g)/b.^2 + m/b*hDot0 - (m.^2*g/b.^2 + m/b*hDot0)*e.^(-b/m.*t1) - (m*g)/b.*t1;
hb = ha(500) + (m.^2*g)/b.^2 + m/b*hDot0 - (m.^2*g/b.^2 + m/b*hDot0)*e.^(-b/m.*(t2-T)) - (m*g)/b.*(t2-T);

plot(ha)
hold on
plot(hb)