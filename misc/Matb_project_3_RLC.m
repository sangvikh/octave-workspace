clc; clear all; close all;
pkg load symbolic;

%Constants
C = 1e-6;
R = 100;
L = 100e-3;

%Initial data
Iamp = 100e-3;
tRamp = 0.01;
Uc = 0;
Il = 0;

%Time data
t = 0;
tEnd = 2*tRamp;
idx = 1;
dt = 1e-5;

%Time loop
while t < tEnd
  %Ramp I
  if t < tRamp
    I = Iamp/tRamp*t;
    Idot = Iamp/tRamp;
  else
    I = Iamp;
    Idot = 0;
  end
  
  %Analytical solution
  %Uanalytic(idx) = 1/3*(heaviside(t-0.01)*sqrt(15)*e^(-5000*t+50)*sinh(1000*sqrt(5)*t-10*sqrt(15))+3*heaviside(t-0.01)*cosh(1000*sqrt(5)*t-10*sqrt(15))*e^(-5000*t+50)-3*heaviside(t-0.01)-15*e^(-5000*t)*sinh(1000*sqrt(15)*t)-3*cosh(1000*sqrt(15)*t)*e^(-5000*t)+3);
  
  %Calculate currents
  Ir = Uc/R;
  Ic = I - Ir - Il;
  
  %Calulate derivatives
  IlDot = Uc/L;
  UcDot = Ic/C;
  
  %Save plot data
  UcPlot(idx) = Uc*1000;
  IPlot(idx) = I*1000;
  tPlot(idx) = t*1000;
  IdotPlot(idx) = Idot;
  
  %Update state vectors
  t = t+dt;
  idx = idx+1;
  Il = Il + IlDot*dt;
  Uc = Uc + UcDot  *dt;
end

%Plot data
hold on;
grid on;
plot(tPlot,UcPlot,'linewidth',2);
%plot(tPlot,Uanalytic,'linewidth',2);
xlabel('Time (ms)');
ylabel('Amplitude (mV)');
%saveas(gcf,'U(t).png')

figure;
hold on;
grid on;
plot(tPlot,IdotPlot,'linewidth',2);
xlabel('Time (ms)');
ylabel('dI/dt (A/s)');
title('Derivative of I(t)');
%saveas(gcf,'Idot(t).png')