clc; clear all; close all;

% Primary wave data
Hs_primary = 4;
fm_primary = 0.1;
primary_direction = pi/2; % 90 degrees

% Secondary wave data
Hs_secondary = Hs_primary/10; % Lower significant wave height
fm_secondary = fm_primary*2; % Different peak frequency
secondary_direction = primary_direction + pi/2; % 90 degrees offset from primary direction

g = 9.81; % acceleration due to gravity

% Frequencies used to generate time series and spectrum
numfreq = 32; % Number of frequency components
minfreq = min(fm_primary, fm_secondary)/2;
maxfreq = max(fm_primary, fm_secondary)*4;
F = linspace(minfreq, maxfreq, numfreq);
dF = F(2) - F(1);

%%% Generate PM spectra %%%
% Primary spectrum
S_primary = PiersonMoskowitz(Hs_primary, fm_primary, F);
% Secondary spectrum
S_secondary = PiersonMoskowitz(Hs_secondary, fm_secondary, F);

% Random phase offset for each frequency with some correlation
rng(1)
phase_primary = 2*pi*cumsum(randn(1, length(F))); % Smooth phase transitions
phase_secondary = 2*pi*cumsum(randn(1, length(F))); % Smooth phase transitions

% Directional spread parameter
s_primary = 500; % Narrow spread for primary waves
s_secondary = 500; % Narrow spread for secondary waves

% Calculate the expected variance for normalization
expected_variance_primary = sum(S_primary * dF);
expected_variance_secondary = sum(S_secondary * dF);

% Spatial grid
x = linspace(-100, 100, 100);
y = linspace(-100, 100, 100);
[X, Y] = meshgrid(x, y);

% Time vector
t = 0:0.1:100; % Increased time resolution for smoother animation

% Example RAO table (amplitude and phase for heave, pitch, roll, yaw)
% Frequencies and directions in the RAO table
RAO_frequencies = linspace(minfreq, maxfreq, 10);
RAO_directions = linspace(0, 2*pi, 10);

% RAO amplitudes and phases for heave, pitch, roll, yaw (example data)
[RAO_F, RAO_DIR] = meshgrid(RAO_frequencies, RAO_directions);
RAO_heave_amp = cos(RAO_F) .* cos(RAO_DIR); % Example amplitude data
RAO_heave_phase = sin(RAO_F) .* sin(RAO_DIR); % Example phase data
RAO_pitch_amp = 0.5 * RAO_heave_amp; % Example pitch amplitude data
RAO_pitch_phase = 0.5 * RAO_heave_phase; % Example pitch phase data
RAO_roll_amp = 0.5 * RAO_heave_amp; % Example roll amplitude data
RAO_roll_phase = 0.5 * RAO_heave_phase; % Example roll phase data
RAO_yaw_amp = 0.5 * RAO_heave_amp; % Example yaw amplitude data
RAO_yaw_phase = 0.5 * RAO_heave_phase; % Example yaw phase data

% Animation function with two wave spectra and ship motions
function animateWavesWithShipMotions(X, Y, t, F, S_primary, S_secondary, dF, phase_primary, phase_secondary, primary_direction, secondary_direction, s_primary, s_secondary, expected_variance_primary, expected_variance_secondary, g, Hs_primary, Hs_secondary, RAO_F, RAO_DIR, RAO_heave_amp, RAO_heave_phase, RAO_pitch_amp, RAO_pitch_phase, RAO_roll_amp, RAO_roll_phase, RAO_yaw_amp, RAO_yaw_phase)
    % Create a new figure for the animation
    figure;
    % Initialize the surface plot
    Z = zeros(size(X));
    h = surf(X, Y, Z);
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Amplitude (m)');
    zlim([-Hs_primary*5 Hs_primary*5]); % Set z-axis limits to primary significant wave height
    title('Wave Surface Animation with Ship Motions');
    hold on;

    % Ship initial position (example: center of the grid)
    ship_x = 0;
    ship_y = 0;

    % Plot the ship as a marker
    ship_handle = plot3(ship_x, ship_y, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Animation loop
    for ti = 1:length(t)
        Z_primary = zeros(size(X));
        Z_secondary = zeros(size(X));
        ship_heave = 0;
        ship_pitch = 0;
        ship_roll = 0;
        ship_yaw = 0;

        for fi = 1:length(F)
            % Wave speed for primary waves
            c_primary = g / (2 * pi * F(fi));
            % Wave number for primary waves
            k_primary = 2 * pi * F(fi) / c_primary;
            % Random direction with spread for primary waves
            theta_primary = primary_direction + (randn() / s_primary);
            % Wave field for primary waves
            Z_primary = Z_primary + sqrt(2 * S_primary(fi) * dF) * cos(k_primary * (X * cos(theta_primary) + Y * sin(theta_primary)) - 2 * pi * F(fi) * t(ti) + phase_primary(fi));

            % Wave speed for secondary waves
            c_secondary = g / (2 * pi * F(fi));
            % Wave number for secondary waves
            k_secondary = 2 * pi * F(fi) / c_secondary;
            % Random direction with spread for secondary waves
            theta_secondary = secondary_direction + (randn() / s_secondary);
            % Wave field for secondary waves
            Z_secondary = Z_secondary + sqrt(2 * S_secondary(fi) * dF) * cos(k_secondary * (X * cos(theta_secondary) + Y * sin(theta_secondary)) - 2 * pi * F(fi) * t(ti) + phase_secondary(fi));

            % Interpolate RAO values for primary waves
            %RAO_heave = interp2(RAO_F, RAO_DIR, RAO_heave_amp, F(fi), theta_primary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_heave_phase, F(fi), theta_primary));
            %RAO_pitch = interp2(RAO_F, RAO_DIR, RAO_pitch_amp, F(fi), theta_primary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_pitch_phase, F(fi), theta_primary));
            %RAO_roll = interp2(RAO_F, RAO_DIR, RAO_roll_amp, F(fi), theta_primary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_roll_phase, F(fi), theta_primary));
            %RAO_yaw = interp2(RAO_F, RAO_DIR, RAO_yaw_amp, F(fi), theta_primary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_yaw_phase, F(fi), theta_primary));

            % Calculate ship motions using RAO
            %ship_heave = ship_heave + real(RAO_heave * sqrt(2 * S_primary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_primary(fi))));
            %ship_pitch = ship_pitch + real(RAO_pitch * sqrt(2 * S_primary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_primary(fi))));
            %ship_roll = ship_roll + real(RAO_roll * sqrt(2 * S_primary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_primary(fi))));
            %ship_yaw = ship_yaw + real(RAO_yaw * sqrt(2 * S_primary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_primary(fi))));

            % Interpolate RAO values for secondary waves
            %RAO_heave = interp2(RAO_F, RAO_DIR, RAO_heave_amp, F(fi), theta_secondary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_heave_phase, F(fi), theta_secondary));
            %RAO_pitch = interp2(RAO_F, RAO_DIR, RAO_pitch_amp, F(fi), theta_secondary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_pitch_phase, F(fi), theta_secondary));
            %RAO_roll = interp2(RAO_F, RAO_DIR, RAO_roll_amp, F(fi), theta_secondary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_roll_phase, F(fi), theta_secondary));
            %RAO_yaw = interp2(RAO_F, RAO_DIR, RAO_yaw_amp, F(fi), theta_secondary) * exp(1i * interp2(RAO_F, RAO_DIR, RAO_yaw_phase, F(fi), theta_secondary));

            % Calculate ship motions using RAO
            %ship_heave = ship_heave + real(RAO_heave * sqrt(2 * S_secondary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_secondary(fi))));
            %ship_pitch = ship_pitch + real(RAO_pitch * sqrt(2 * S_secondary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_secondary(fi))));
            %ship_roll = ship_roll + real(RAO_roll * sqrt(2 * S_secondary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_secondary(fi))));
            %ship_yaw = ship_yaw + real(RAO_yaw * sqrt(2 * S_secondary(fi) * dF) * exp(1i * (-2 * pi * F(fi) * t(ti) + phase_secondary(fi))));
        end

        Z_primary = Z_primary / sqrt(expected_variance_primary);
        Z_secondary = Z_secondary / sqrt(expected_variance_secondary);

        % Combine the wave fields with appropriate scaling
        Z = Z_primary + Z_secondary * (Hs_secondary / Hs_primary);

        % Update the surface plot
        set(h, 'ZData', Z);
        drawnow;
        %pause(t(2) - t(1)); % Variable delay for real-time animation

        % Update the ship's position and orientation based on motions
        ship_z = ship_heave;
        set(ship_handle, 'ZData', ship_z);

        % Display ship motions
        %fprintf('Time: %.2f s, Heave: %.2f m, Pitch: %.2f deg, Roll: %.2f deg\n', t(ti), ship_heave, ship_pitch, ship_roll);
    end
end

% Call the animation function with two wave spectra and ship motions
animateWavesWithShipMotions(X, Y, t, F, S_primary, S_secondary, dF, phase_primary, phase_secondary, primary_direction, secondary_direction, s_primary, s_secondary, expected_variance_primary, expected_variance_secondary, g, Hs_primary, Hs_secondary, RAO_F, RAO_DIR, RAO_heave_amp, RAO_heave_phase, RAO_pitch_amp, RAO_pitch_phase, RAO_roll_amp, RAO_roll_phase, RAO_yaw_amp, RAO_yaw_phase);

