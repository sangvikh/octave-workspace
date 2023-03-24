pkg load symbolic;
clc;
clear all;
close all;

syms k1 k2 k3 k4 k5;

Keq = (((1/(2*k1)+1/(k2)+1/(2*k3))^-1+k4)^-1+1/k5)^-1
simplify(Keq)

simple = (k5*(2*k1*k2*k3 + k1*k2*k4 + 2*k1*k3*k4 + k2*k3*k4))/(2*k1*k2*k3 + k1*k2*k4 + k1*k2*k5 + 2*k1*k3*k4 + 2*k1*k3*k5 + k2*k3*k4 + k2*k3*k5)