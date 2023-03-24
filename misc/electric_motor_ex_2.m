% Parameters
N_s = 100; % turns
l_g = 1e-3; % m
mu_0 = 4*pi*1e-7;

% Calculations
% a)
B_a_0 = mu_0*N_s/2/l_g*10*sind(0)
B_a_90 = mu_0*N_s/2/l_g*10*sind(90)
B_a_135 = mu_0*N_s/2/l_g*10*sind(135)
B_a_210 = mu_0*N_s/2/l_g*10*sind(210)
% b)
Dist = 2

theta = linspace(0,400);
B_a = mu_0*N_s*cosd(theta)/2/l_g*10*sind(0);
B_b = mu_0*N_s*cosd(theta)/2/l_g*10*sind(90);
B_c = mu_0*N_s*cosd(theta)/2/l_g*10*sind(135);
B_d = mu_0*N_s*cosd(theta)/2/l_g*10*sind(210);

plot(theta,B_a);
grid on;
hold on;
plot(theta,B_b);
plot(theta,B_c);
plot(theta,B_d);
