% Parameters:
J_1 = 2; N_1 = 4; D_1 = 1;
J_2 = 1; N_2 = 12; N_3 = 4; D_2 = 2;
J_3 = 16; N_4 = 16; D_3 = 32;
K = 64;
eta = 0.8;

% Calculations
n1 = N_1/N_2;
n2 = N_3/N_4;
Jeq = J_1 + n1^2*J_2 + n1^2*n2^2*J_3;

% a) Find the transfer function:
s = tf('s');
G = n1/(s^2*Jeq + s*(D_1 + n1^2/eta*D_2 + n1^2*n2^2/eta^2*D_3) + n1^2*n2^2/eta^2*K);