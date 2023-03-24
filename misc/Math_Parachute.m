clc; clear all; close all;

%Constants
m = 70;
g = 9.81;
b1 = 12.9566;
b2 = 7*b1;
b = b1;         %Initialize b

%Initial data
h0 = 3000;      %Initial height
h = h0;         %Initialize h
hDot0 = 0;      %Initial velocity
hDot = hDot0;   %Initializes hDot
T = 40;         %Parachute opening time
cond = 0;       %Condition flag for setting new initial conditions at t = T

%Time data
t = 0;          %Initial t = 0
idx = 1;        %Index for storing plot
dt = 0.001;       %Time step

%Time loop
while h > 0
  %Switch constants at t = T
  if t < T
    %This equation is the analytical symbolic solution to the IVP
    ha(idx) = h0 + (m^2*g)/b^2 + m/b*hDot0 - (m^2*g/b^2 + m/b*hDot0)*e^(-b/m*t) - (m*g)/b*t;
  else
    if cond <= 0;     %This condition changes constants at t = T
      cond = 1;
      %Calculate h at t = T
      h0 = h0 + (m^2*g)/b^2 + m/b*hDot0 - (m^2*g/b^2 + m/b*hDot0)*e^(-b/m*(T)) - (m*g)/b*(T);
      %Calculate hDot at t = T
      hDot0 = (m*g/b+hDot0)*exp(-b/m*T)-m*g/b;
      %Set b = b2
      b = b2;
    end
    %Analytical solution with t substituted for t-T
    ha(idx) = h0 + (m^2*g)/b^2 + m/b*hDot0 - (m^2*g/b^2 + m/b*hDot0)*e^(-b/m*(t-T)) - (m*g)/b*(t-T);
  end
  
  %Acceleration of man
  hDotDot = (-m*g - b*hDot)/m;
  
  %Save plot data
  tPlot(idx) = t;
  hPlot(idx) = h;
  hDotPlot(idx) = hDot;
  
  %Update state variables
  h = h + hDot*dt;
  hDot = hDot + hDotDot*dt;
  
  %Analytical with the rounded constants from the project
    if t < 40
    har(idx) = 3286.19-286.19*exp(-0.185*t)-52.99*t;
  else
    har(idx) = 1131.37+35.02*exp(-1.296*(t-40))-7.57*(t-40);
  end
  
  %Update time data
  t = t + dt;
  idx = idx + 1;  
end

%Plot error between numerical and analytical solution
hold on;
grid on;

%Exact constants
plot(tPlot,hPlot-ha);
%Rounded constants
%plot(tPlot,hPlot-har);

legend('Exact constants','Rounded constants')

xlabel('t');
ylabel('Error(t)');

%Limit axes
%xlim([0 200]);

%Save plot
saveas(gcf,'Error.png')

%Plot h(t)
figure;
grid on;
hold on;
plot(tPlot,hPlot);
plot(tPlot,ha);

legend('Numerical solution','Analytical solution')

xlabel('t');
ylabel('h(t)');

%Limit axes
%xlim([0 200]);
%ylim([0 3000]);

%Save plot
saveas(gcf,'Analytical_numerical.png')