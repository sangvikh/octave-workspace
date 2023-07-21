% Define Constants
r_earth = 6371; % Radius of Earth in kilometers
mu = 398600.4418; % Gravitational parameter km^3/s^2

% Create a Sphere (Earth)
[r, c, z] = sphere(100);
x = r_earth * r;
y = r_earth * c;
z = r_earth * z;

% Plot Earth
figure;
hold on;
surf(x, y, z, 'EdgeColor', 'none', 'FaceColor', "#0072BD");

% Satellite Orbit Parameters
a = 7000; % Semi-major axis in kilometers
e = 0.1;  % Eccentricity
i = deg2rad(45); % Inclination in radians
Omega = deg2rad(90); % RAAN in radians
omega = deg2rad(45); % Argument of perigee in radians

% Time (since perigee passage)
T = 2*pi*sqrt(a^3/mu); % Period of the orbit
t = linspace(0, T, 1000); % Time points

% Calculate Mean anomaly
M = sqrt(mu/a^3) * t;

% Solve Kepler's equation for Eccentric anomaly (using Newton-Rhapson method)
tol = 1e-8; % Tolerance for the solution
E = M; % Initial guess
for k = 1:10
    E = E - (E - e*sin(E) - M) ./ (1 - e*cos(E));
    if abs(E - e*sin(E) - M) < tol, break, end
end

% True anomaly
nu = 2*atan2(sqrt(1+e)*sin(E/2), sqrt(1-e)*cos(E/2));

% Radius
r = a*(1 - e*cos(E));

% Calculate Satellite Position in Orbit Frame
x_orbit = r .* cos(nu);
y_orbit = r .* sin(nu);
z_orbit = zeros(size(nu));

% Rotate to ECI frame
R3_Omega = [cos(Omega) sin(Omega) 0;
            -sin(Omega) cos(Omega) 0;
            0 0 1];
R1_i = [1 0 0;
        0 cos(i) sin(i);
        0 -sin(i) cos(i)];
R3_omega = [cos(omega) sin(omega) 0;
            -sin(omega) cos(omega) 0;
            0 0 1];
R = R3_Omega' * R1_i' * R3_omega';

pos_eci = R * [x_orbit; y_orbit; z_orbit];

% Plot Satellite Orbit
plot3(pos_eci(1,:), pos_eci(2,:), pos_eci(3,:), 'r', 'LineWidth', 2);
axis equal;

% Title and Labels
title('Satellite Orbiting Earth');
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
grid on;

