clear
all;
L1=1.0;         % Link
length
1
L2=0.75;        % Link
length
2
figure
;
for(q1=0:0.1:pi/2
)
% Joint angle 1
q2=-q1
;
% Joint angle 2
T1=RotZ(q1)*TransX(L1);
% DH table–1st line
T2=RotZ(q2)*TransX(L2);
% DHtable–2nd line
T=T1*T2;
% mergebothlines
h=plot([0 T1(1,4)],[0 T1(2,4)],'b');
% plot a figure
set
(h,'LineWidth',3
); % line
width
hold
on
; %
wait
for
the
second
plot in
the
same Fig
h=plot([T1(1,4) T(1,4)],[T1(2,4) T(2,4)],'r');
set
(h,'LineWidth',3);
grid
on
; %
use
grid
axis
([0 2 0 1]); % Min/
max
for
axes
in plot
pause(0.1
); %
wait
before
the
next
iteration
end
;
