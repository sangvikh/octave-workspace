clc;clear;close all;

Fl = 300000; % 300 kN load
theta = atand(550/1200);

Fc = (Fl*2250 - Fl*(2500 + 550 + 250*sind(40+90))*cosd(40) + (2000 - 1200 + 250*cosd(40+90))*Fl*sind(40))/(cosd(30)*670 + sind(30)*150)
Rax = Fl*cosd(40) + Fc*cosd(30)
Ray = Fl + Fc*sind(30) + Fl*sind(40)
Rbx = -Fl*(cosd(theta) - sind(40))
Rby = Fl*(sind(40) + sind(theta))
Rcx = Fl*cosd(theta)
Rcy = Fl*(1- sind(theta))