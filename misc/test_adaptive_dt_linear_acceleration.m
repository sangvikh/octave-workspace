clc; clear all; close all;

%Constants
m = 10;
k = 0.01;      %Slope of acceleration curve

%Initial data
y0 = 0;      %Initial position
y = y0;         %Initialize pos
yDot0 = 0;      %Initial velocity
yDot = yDot0;   %Initializes velocity

%Adaptive dt settings
dt = 1;         %First time step, will converge on a good timestep if too high
correctionCount = 0;
maxStep = 0.01;
%Initialize last known good values
yPrev = y0;
yDotPrev = yDot0;
yDotDotPrev = 0;
idxPrev = 1;
tPrev = 0;

%Time data
t = 0;          %Initial t = 0
tEnd = 100;
idx = 1;        %Index for storing plot

%Time loop
while t < tEnd
  %Analytic expressino
  ya(idx) = y0-k/6/m+yDot0*t+k/6/m*t^3;
    
  %Acceleration of man
  yDotDot = (k*t)/m;
   
  %Save plot data
  tPlot(idx) = t;
  yPlot(idx) = y;
  yDotPlot(idx) = yDot;
  yDotDotPlot(idx) = yDotDot;
  dtPlot(idx) = dt;
  
  %If step is too large, go back 1 timestep, reduce dt.
  if abs(yDotDot)*dt > 1.1*maxStep    
    %Set to last good values
    y = yPrev;
    yDot = yDotPrev;
    idx = idxPrev;
    t = tPrev;
    
    %Reduce dt
    dt = dt*0.8;
    correctionCount = correctionCount + 1;
  else
    %Last known good values
    yPrev = y;
    yDotPrev = yDot;
    yDotDotPrev = yDotDot;
    idxPrev = idx;
    tPrev = t;
    
    %%THIS STEP MIGHT NOT BE ACCURATE, THERFORE GOOD VALUES ARE BEFORE THIS%%
    
    %Update state variables
    y = y + yDot*dt;
    yDot = yDot + yDotDot*dt;
    
    %Update time data
    t = t + dt;
    idx = idx + 1;
    
    %Adjust dt to keep stepsize the same
    if abs(yDotDot)*dt > maxStep
      dt = dt*0.95;
    else
      dt = dt*1.05;
    end
  end
  %Break out of loop if t is above tEnd
  if t > tEnd
    break
  end
end

%Plot error between numerical and analytical solution
hold on;
grid on;

%Error
plot(tPlot,yPlot-ya);

%Position
%plot(tPlot,ya);

%dt
%plot(tPlot,dtPlot);

xlabel('t');
ylabel('Error(t)');

correctionCount