clc; clear all; close all;

%Simulation parameters
dt = 10;                     %s
scale = 0.001;              %can't plot too large numbers have to scale down
time = 60*24;                   %hours to simulate
planetScale = 5;            %Scale up planets to make them visible
G = 6.667408*10^-11;        %m^3*kg^-1*s^-1


%Earth parameters
earthRadius = 6371000;      %m
earthMass = 5.9722*10^24;   %kg

%Moon parameters
moonMass = 7.34767309*10^22;   %kg
moonRadius = 1737100;        %m
moonOrbitRadius = 387500000; %m
moonOrbitalPeriod = 27.32;        %days
moonTheta = 1*pi()/2;
moonPos = moonOrbitRadius*[cos(moonTheta),sin(moonTheta)];

%Initial sattelite parameters
satV = 7667+3100;                            %m/s ISS = 7667,
altitude = 400000;                      %m  ISS = 400000,
theta = 3.7*pi()/2;

%Initial position and velocity
rSat = altitude + earthRadius;
r_sat_earth = rSat*[cos(theta), sin(theta)];       %m
satV = satV*[cos(theta+pi()/2), sin(theta+pi()/2)];     %m/s

%Draw initial positions
%drawCircle(planetScale*earthRadius, 0, 0, scale);
%drawCircle(planetScale*moonRadius, moonPos(1), moonPos(2), scale);

%Calculate new angle and integrate
t = 0;
j = 0;
for i = 0:1:100000
  j = j+1;

  %Location of moon
  moonTheta = moonTheta + 2*pi()/moonOrbitalPeriod/24/3600*dt;
  moonPos = moonOrbitRadius*[cos(moonTheta),sin(moonTheta)];
  r_moon_sat = moonPos - rSat;

  %calculation of orbital parameters
  theta = atan2(r_sat_earth(2),r_sat_earth(1));
  rSat = norm(r_sat_earth);
  a_earth_sat = -G*earthMass/rSat^3*[r_sat_earth(1), r_sat_earth(2)];
  a_moon_sat = -G*moonMass/norm(r_moon_sat)^3.*[r_moon_sat(1), r_moon_sat(2)];
  a = a_earth_sat; + a_moon_sat;

  %integrator
  satV = satV + a*dt;
  r_sat_earth = r_sat_earth + satV*dt;

  %save plots
  posX(j) = r_sat_earth(1);
  posY(j) = r_sat_earth(2);
  theta_plot(j) = theta;
  t_plot(j) = t;

  %Update time
  t = t + dt;

  %Stop loop after time has passed
  if t > 3600*time
    break;
  endif
end

plot(scale*posX, scale*posY);
hold on;
grid on;

drawCircle(planetScale*moonRadius, moonPos(1), moonPos(2), scale);
