r1 = [1 0 0]';
r2 = [0 1 0]';

T1 = rotz(180)*roty(90)*rotx(0)
T2 = rotx(0)*roty(90)*rotz(180)

T1*r1
T2*r2

s = tf('s');
G = 1/(s^2+3*s+5);
step(G)
