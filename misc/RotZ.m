function T=RotZ(q)
cq=cos(q);
sq=sin(q);
T = [cq -sq 0 0 ; sq cq 0 0 ; 0 0 1 0 ; 0 0 0 1];