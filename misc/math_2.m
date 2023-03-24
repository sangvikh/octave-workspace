clc; clear all; close all;

t = linspace(0,3);

h1 = (2-t).^2;
for i = 1:length(t)
  if t(i) < 2
    h2(i) = h1(i);
  else
    h2(i) = 0;
  end
end

hold on;
grid on;
plot(t,h2);
title('Height vs time');
xlabel t
ylabel h
saveas(gcf,'h2.png')