% Set up initial conditions
G = 6.67408e-11;  % gravitational constant
m1 = 5.97e24;     % mass of Earth
m2 = 7.34e22;     % mass of Moon
m3 = 1000;        % mass of spacecraft
r1 = [0;0;0];     % position of Earth
r2 = [384400e3;0;0];  % position of Moon
r3 = [384400e3+400e3;0;0]; % position of spacecraft
v1 = [0;0;0];     % velocity of Earth
v2 = [0;1022;0];  % velocity of Moon
v3 = [0;1100;0];  % velocity of spacecraft
tspan = [0 100000]; % simulation time

% Define the function that calculates the accelerations
function a = acceleration(t,x)
    G = 6.67408e-11;  % gravitational constant
    m1 = 5.97e24;     % mass of Earth
    m2 = 7.34e22;     % mass of Moon
    m3 = 1000;        % mass of spacecraft
    % x is a 12x1 vector containing the positions and velocities of the three bodies
    r1 = x(1:3); v1 = x(4:6);
    r2 = x(7:9); v2 = x(10:12);
    r3 = x(13:15); v3 = x(16:18);

    % Calculate the distances and gravitational forces between the bodies
    d12 = norm(r2-r1);
    F12 = G*m1*m2/d12^2 * (r2-r1)/d12;
    d13 = norm(r3-r1);
    F13 = G*m1*m3/d13^2 * (r3-r1)/d13;
    d23 = norm(r3-r2);
    F23 = G*m2*m3/d23^2 * (r3-r2)/d23;

    % Calculate the accelerations of the bodies
    a1 = (F12+F13)/m1;
    a2 = (-F12+F23)/m2;
    a3 = (-F13-F23)/m3;

    % Return the accelerations as a 9x1 column vector
    a = [a1;a2;a3];
end

% Solve the differential equations using ode45
x0 = [r1;v1;r2;v2;r3;v3];
options = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t,x] = ode45(@acceleration,tspan,x0,options);

% Plot the trajectories of the bodies
figure;
hold on;
plot3(x(:,1),x(:,2),x(:,3),'b'); % Earth
plot3(x(:,7),x(:,8),x(:,9),'g'); % Moon
plot3(x(:,13),x(:,14),x(:,15),'r'); % spacecraft
xlabel('x');
ylabel('y');
zlabel('z');
title('Trajectories of three bodies');
legend('Earth','Moon','Spacecraft');

