clc; clear all; close all;

% Wave data
Hs = 1.5;
fm = 0.1;

% Frequencies used to generate time series and spectrum
numfreq = 32;
minfreq = fm/2;
maxfreq = fm*4;
F = linspace(minfreq, maxfreq, numfreq);
dF = F(2) - F(1);

%%% Generate PM spectrum %%%
% PiersonMoskowitz(Hs, fm, f)
S = PiersonMoskowitz(Hs,fm,F);
% Random phase offset for each frequency
rng(1)
phase = 2*pi*rand(1,length(F));

% Plot spectrum
figure;
hold on;
grid on;
plot(F,S);
title("Wave Spectrum (Pierson Moskowitz)")
xlabel("f (Hz)")
ylabel("S(f) (m^2)")



%%%%%%%%%% Generate time series data %%%%%%%%%%

% Time vector for which to generate time series plot
t = 0:0.01:600;

% Generate
A = zeros(length(t),1);
for i = 1:length(t)
  A(i,1) = sum((2*pi*S*dF).^0.5.*sin(2*pi*F*t(i) + phase));
end

% Plot
figure;
grid on;
hold on;title("Wave data")
ylabel("Amplitude (m)")
xlabel("Time (s)")
plot(t,A);



%%%%%%%%%% FFT %%%%%%%%%%
Y = fft(A);
L = length(A);
Fs = 1/(t(2)-t(1));

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

%% Plot FFT %%
figure;
hold on;
grid on;
plot(f,P1)
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")
xlim([minfreq maxfreq])
