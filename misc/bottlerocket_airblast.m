clc;clear all; close all;

Vbottle=10;        %l, volume of bottle
Vfill=5;         %l, volume filled
Dnozzle=2.5;        %cm, nozzle diameter
Dbottle=50;        %cm, bottle diameter, for drag calculations
drymass=4;        %kg, empty mass of bottle
p0=10;               %bar, start pressure in bottle
theta=85;           %launch angle;
dt=0.0001;           %time constant;
cdrag=0.8;             %coefficient of drag, source: NASA, https://www.grc.nasa.gov/www/k-12/bottlerocket/br2d_b.swf
cdischarge=0.8;     %coefficient of discharge, to adjust the flow calculations.
g=9.81;             %gravity;
rhoatmo=1.2;        %density of atmosphere @20*C [kg/m^3]
rholiquid=1000;        %kg/m^3
gamma=1.4;          %adiabatic expansion of air



%Calculate!
Abottle=pi*(Dbottle/200)^2; %m^2
Anozzle=pi*(Dnozzle/200)^2; %m^2
vgas0=Vbottle-Vfill;        %l
vgas=vgas0;                 %l
mdot=0;                     %kg/s
p=p0;                       %bar
mgas=vgas/1000*rhoatmo*p0;  %Mass of air
m0=drymass+Vfill+mgas;      %kg
mgas0=mgas;
rho=rholiquid;
m=m0;
ax=0;
ay=0;
vx=0;
vy=0;
x=0;
y=0;
idx=0;

%integrate!
for i=0:dt:15;

    %Index, time
    idx=idx+1;
    t(idx)=i;

    %Calculate flow and pressure
      % Gas expelling mode
    if vgas>=Vbottle                            %Change rho, liquid/air
        vgas=Vbottle;                          %Volume of gas in bottle
        mgas=mgas-mdot;                         %Mass of gas left
        p=p1*(mgas/mgas0)^gamma;                %Pressure of gas
        rho=rhoatmo*(p+1);                          %Density of gas
      % Water expell mode, ammount of gas stays the same
    else
        vgas=vgas0+m0-m;
        p=p0*(vgas0/vgas)^(gamma);                 %Pressure, adiabatic expansion
        p1=p;
    end

    ve=sqrt(2*p*100000/rho)*cdischarge;        %Exit velocity, assuming turbulent flow
    q=Anozzle*ve;                              %flow

    %Mass01;           %time constant;
    mdot=q*rho*dt;
    m=m-mdot;

    if m<=drymass
        p=0;
        q=0;
        ve=0;
        m=drymass;
        mdot=0;
    end
    dv=ve*log((m+mdot)/m);
    thrust=(dv/dt)*m;

    %Drag
    fdragx=(0.5*rhoatmo*vx^2*cdrag*Abottle)*sign(vx);
    dvdragx=fdragx/m;
    fdragy=(0.5*rhoatmo*vy^2*cdrag*Abottle)*sign(vy);
    dvdragy=fdragy/m;

    %Integrator
    ax=(dv*cosd(theta)-dvdragx*dt)/dt;
    ay=(dv*sind(theta)-(g+dvdragy)*dt)/dt;
    vx=vx+ax*dt;
    vy=vy+ay*dt;
    x=x+vx*dt;
    y=y+vy*dt;

    %Save plots
    if m>drymass
        tthrust(idx)=i;
        thrustplot(idx)=thrust;
        athrustplot(idx)=sqrt(ay^2+ax^2);
        pthrustplot(idx)=p;
        vethrustplot(idx)=ve;
        mthrustplot(idx)=m;
        mgasthrustplot(idx)=mgas;
        mdothrustplot(idx)=mdot/dt;
    end
    vgasplot(idx)=vgas;
    qplot(idx)=q;
    veplot(idx)=ve;
    pplot(idx)=p;
    mplot(idx)=m;
    axplot(idx)=ax;
    axplot(idx)=ax;
    ayplot(idx)=ay;
    vxplot(idx)=vx;
    vyplot(idx)=vy;
    xplot(idx)=x;
    yplot(idx)=y;
    if y<0
        break
    end
end

%Plot whatever you need
hold on;
grid on;
%axis equal;
plot(xplot,yplot);
%plot(tthrust,thrustplot);
%plot(tthrust,athrustplot);
%plot(tthrust,pthrustplot);
%plot(tthrust,vethrustplot);
%plot(tthrust,mthrustplot);
%plot(tthrust,mgasthrustplot);
%plot(tthrust,mdothrustplot);
%plot(t,mplot);
%plot(t,vgasplot);
%plot(t,qplot);
%plot(t,veplot);
%plot(t,pplot);
%plot(t,axplot);
%plot(t,ayplot);
%plot(t,vxplot);
%plot(t,yplot);
%plot(t,vyplot);

%Save plot
%saveas(gcf,'Plot.png')

%Show maximas
max(yplot)
