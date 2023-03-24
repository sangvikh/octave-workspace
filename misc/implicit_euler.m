function [t,state] = implicit_euler(f, tspan, y0, dt)
% IMPLICIT_EULER Solve a system of first-order differential equations using Implicit Euler method
%   [t,state] = IMPLICIT_EULER(f, tspan, y0, dt) solves the system of
%   first-order differential equations y' = f(t,y) for tspan = [t0 tf] and
%   initial conditions y(t0) = y0, using Implicit Euler method with time
%   step dt. The function returns the time array t and the state array state.
%   The function f should be a function handle that accepts two input
%   arguments t and y, and returns a column vector.

    % Initial conditions
    t0 = tspan(1);
    tf = tspan(2);
    n = ceil((tf-t0)/dt) + 1;
    state = zeros(n, length(y0));
    state(1,:) = y0;
    t = t0:dt:tf;

    % Numerical integration with Implicit Euler method
    for i = 1:n-1
        % Solve for the next state using fsolve
        f_implicit = @(y_next) y_next - dt*f(t(i+1),y_next) - state(i,:)';
        options = optimoptions('fsolve','Display','off');
        state(i+1,:) = fsolve(f_implicit,state(i,:)',options)';
    end
end

