input = csvread('dimensions.txt');
input2 = csvread('dimensions2.txt');

x = input(:,1);
y= input(:,2);

%Plot first engine
plot(input(:,1),input(:,2));
hold on;
grid on;
axis equal;
plot(input(:,1),-input(:,2));

%Plot other engine
plot(input2(:,1),input2(:,2));
plot(input2(:,1),-input2(:,2));