clc; clear all; close all;

% Local position in latitude and longtitude
lat = 58.286070;
long = 8.289479;

% Convert to ECEF coordinates
% https://en.wikipedia.org/wiki/Local_tangent_plane_coordinates
% phi = lat, lambda = long
phi = lat;
lambda = long;
R = [-sind(phi)*cosd(lambda), -sind(phi)*sind(lambda),  cosd(phi);
     -sind(lambda),           cosd(lambda),             0;
     -cosd(phi)*cosd(lambda), -cosd(phi)*sind(lambda),  -sind(phi)];

pos = [lat; long; 40000];

posNED = R*pos
