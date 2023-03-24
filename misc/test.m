% MAS409 - Tutorial 6 %

global T_M omega_s s_N P_N U p Q_N
% Parameters from datasheet:
PF_N = 0.68; % Nominal power factor
f=50;
n_m = 960;
U = 400;
eta_N = 0.849;
p = 3; % pole pairs
I_N=10;
T_n = 39.7;

%Parameters calculated directly from datasheet:
omega_s = 2*pi*f/p; % Synchronous angular speed
n_s = omega_s/(2*pi)*60; % Synchronous speed
s_N = (n_s-n_m)/n_s; % Nominal slip
V_s = U/sqrt(3); % Phase voltage

% Question 1: (read or calculated directly from datasheet) 
T_M = T_n*4.6; % Maximum torque
P_N = n_m/60*2*pi*T_n; % Nominal mechanical power
Q_N = U/sqrt(3)*I_N*sin(acos(PF_N)); % Reactive power

% tests for questions 2, 3, 4, 5, 6, and 7:
%[R_Th_test, X_Th_test] = f1(1, 2, 3);
%s_M_test = f2(1, 2, 3, 4, 5);
%[I_r_test, I_s_test] = f3(U,1,2,3, 0.01);
%Tau_test = f4(omega_s,2, 1, 0.01);
%Q_test = f5(U,2-3*i);
%P_m_test = f6(10,omega_s,0.01);

% Question 8: Initial values:
x0 = [0, 0, 0];
% Optimisation:
options = optimoptions('lsqnonlin','Display','iter');
% Uncomment the following line once you have answered questions 1 to 8.
% [x_sol,resnorm,residual,exitflag,output] = lsqnonlin(@myfun,x0,[],[],options)

% Question 9: (use the results of the optimisation line 40)
R_r_opt = 0;
R_s_opt = 0;
X_sd_opt = 0;
X_rd_opt = 0;
X_m_opt = 0;

function F = myfun(x)
global T_M omega_s s_N P_N U p Q_N

%x = [R_r, X_m, X_sd]'
R_r = abs(x(1)); X_m=abs(x(2)); X_sd = abs(x(3));
    
[R_Th, X_Th] = f1(R_r, X_m, X_sd);
s_M = f2(R_r, X_m, X_sd, R_Th, X_Th);
[I_r, I_s] = f3(U,R_r, X_m, X_sd, s_N);
[I_r_s_M, I_s_s_M] = f3(U,R_r, X_m, X_sd, s_M);
Tau = f4(omega_s,I_r, R_r, s_N)
Q = f5(U,I_s);
P_m = f6(Tau,omega_s,s_N);
Tau_max = f4(omega_s,I_r_s_M, R_r, s_M);

F = [(P_N - P_m)/P_N, (Q_N - Q)/Q_N, (T_M-Tau_max)/T_M];  % Compute function values at x
end

% Question 2: (modify the script inside the function)
function [R_Th, X_Th] = f1(R_r, X_m, X_sd)
R_Th = 0;
X_Th = 0;
end

% Question 3: (modify the script inside the function)
function s_M = f2(R_r, X_m, X_sd, R_Th, X_Th)
s_M = 0;
end

% Question 4: (modify the script inside the function)
function [I_r, I_s] = f3(U,R_r, X_m, X_sd, s) % (I_r ans I_s are vectors (complex numbers)
I_s = 0;
I_r = 0;
end

% Question 5: (modify the script inside the function)
function Tau = f4(omega_s,I_r, R_r, s)
Tau = 0;
end

% Question 6: (modify the script inside the function)
function Q = f5(U,I_s)
Q = 0;
end

% Question 7: (modify the script inside the function)
function P_m = f6(Tau,omega_s,s)
P_m = 0;
end
