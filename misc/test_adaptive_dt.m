clc; clear all; close all;

%Constants
m = 70;
g = 9.81;
b1 = 12.96;
b2 = 7*b1;
b = b1;         %Initialize b

%Initial data
h0 = 3000;      %Initial height
h = h0;         %Initialize h
hDot0 = 0;      %Initial velocity
hDot = hDot0;   %Initializes hDot
T = 40;         %Parachute opening time

%Adaptive dt settings
dt = 1;         %First time step, will converge on a good timestep if too high
correctionCount = 0;
maxStep = 0.01;
%Initialize last known good values
hPrev = h0;
hDotPrev = hDot0;
hDotDotPrev = 0;
idxPrev = 1;
tPrev = 0;

%Calculate solution constants
H_T = h0 + m^2*g/b1^2 + m/b1*hDot0 - (m^2*g/b1^2 + m/b1*hDot0)*exp(-b1/m*T) - m*g/b1*T;
V_T = (m*g/b1)*exp(-b1/m*T) - m*g/b1;

%Time data
t = 0;          %Initial t = 0
idx = 1;        %Index for storing plot

%Time loop
while h > 0
  %Switch constants at t = T
  if t < T
    b = b1;
    ha(idx) = h0 + m^2*g/b1^2 + m/b1*hDot0 - (m^2*g/b1^2 + m/b1*hDot0)*exp(-b1/m*t) - m*g/b1*t;
  else
    b = b2;
    ha(idx) = H_T + m^2*g/b2^2 + m/b2*V_T - (m^2*g/b2^2 + m/b2*V_T)*exp(-b2/m*(t-T)) - m*g/b2*(t-T);
  end
  
  %Acceleration of man
  hDotDot = (-m*g - b*hDot)/m;
   
  %Save plot data
  tPlot(idx) = t;
  hPlot(idx) = h;
  hDotPlot(idx) = hDot;
  hDotDotPlot(idx) = hDotDot;
  dtPlot(idx) = dt;
  
  %If step is too large, go back 1 timestep, reduce dt.
  if abs(hDotDot)*dt > 1.1*maxStep    
    %Set to last good values
    h = hPrev;
    hDot = hDotPrev;
    idx = idxPrev;
    t = tPrev;
    
    %Reduce dt
    dt = dt*0.5;
    correctionCount = correctionCount + 1;
  else
    %Last known good values
    hPrev = h;
    hDotPrev = hDot;
    hDotDotPrev = hDotDot;
    idxPrev = idx;
    tPrev = t;
    
    %%THIS STEP MIGHT NOT BE ACCURATE, THERFORE GOOD VALUES ARE BEFORE THIS%%
    
    %Update state variables
    h = h + hDot*dt;
    hDot = hDot + hDotDot*dt;
    
    %Update time data
    t = t + dt;
    idx = idx + 1;
    
    %Adjust dt to keep stepsize the same
    if abs(hDotDot)*dt > maxStep
      dt = dt*0.95;
    else
      dt = dt*1.05;
    end
  end
end

%Plot error between numerical and analytical solution
hold on;
grid on;

%Error
plot(tPlot,hPlot-ha);

%Height
%plot(tPlot,hPlot,tPlot,ha);

%dt
%plot(tPlot,dtPlot);

xlabel('t');
ylabel('Error(t)');

correctionCount