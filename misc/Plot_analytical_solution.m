clc; clear all; close all;

%Time data
idx = 1;
t = 0;
dt = 0.01;

while t < 200
  %Conditional height function
  if t < 40
    h(idx) = 3286.19-286.19*exp(-0.185*t)-52.99*t;
  else
    h(idx) = 1131.37+35.02*exp(-1.296*(t-40))-7.57*(t-40);
  end

%Plot time
tPlot(idx) = t;

%Update time and index
idx = idx + 1;
t = t+dt;
end

%Plot graph
hold on;
grid on;
plot(tPlot,h);

xlabel('t');
ylabel('h');

%Limit axes
xlim([0 200]);
ylim([0 3000]);

%Save plot
saveas(gcf,'Analytical_solution.png')