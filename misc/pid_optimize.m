pkg load control;

function e = opt(x)
G    = tf([1],[0.001 1]);
C    = pid(x(1),x(2),x(3));

%all resolutions
  %these make sure that it is stable
[y1,t]= step(feedback(G*C),100);
[y2,t]= step(feedback(G*C),10);
  %these make sure it minimizes the transient
[y3,t]= step(feedback(G*C),1);
[y4,t]= step(feedback(G*C),0.1);
y = [y1;y2;y3;y4];

%ISE
e = (y-1)'*(y-1);
endfunction


x = [1 1 3];
[best_x, fval] = fminsearch (@opt, x);

%your plant
G    = tf([1],[1 6 5 0]);
%best controller
C    = pid(best_x(1),best_x(2),best_x(3));
step(feedback(G*C),5)
