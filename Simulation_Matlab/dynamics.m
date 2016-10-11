function Fmatrix = dynamics(t,x)

global mb ml g k Lspring  
global bhip bspring
global ph_old fi_desired
global t_prev_stance  
global long_flight_phases_no
global flight_phases_no
global tfinal
global i2

i2 = i2 +1; % increase the counter

%-------------------------------------------------------------------------%
% x(1) = xb 
% x(2) = xbdot 
% x(3) = yb
% x(4) = ybdot
% x(5) = thl
% x(6) = thldot
% x(7) = l
% x(8) = ldot
%-------------------------------------------------------------------------%
xb = x(1);
xbdot = x(2);
yb = x(3);
ybdot = x(4);
thl = x(5);
thldot = x(6);
l = x(7);
ldot = x(8);


%-------------------------------------------------------------------------%
% Coordinates and velocities of the foot
%-------------------------------------------------------------------------%
xf=xb+l.*sin(thl);
xfdot=xbdot+l.*thldot.*cos(thl)+ldot.*sin(thl);
yf=yb+(-1).*l.*cos(thl);
yfdot=ybdot+(-1).*ldot.*cos(thl)+l.*thldot.*sin(thl);


%-------------------------------------------------------------------------%
% Hip torque - Controller
%-------------------------------------------------------------------------%
[tau, ph_old, t_prev_stance, long_flight_phases_no, ...
    flight_phases_no, fi_desired]= controller(...
    t, xbdot, yb, ybdot, thl, thldot, yf, ...
    ph_old, t_prev_stance, fi_desired, ...
    long_flight_phases_no, flight_phases_no);


%-------------------------------------------------------------------------%
% Forces from the ground
%-------------------------------------------------------------------------%
[N, F, slip] = ground_forces(yf, xfdot, yfdot);

    
%-------------------------------------------------------------------------%
% F matrix
%-------------------------------------------------------------------------%
Fmatrix = zeros(8,1);


%-------------------------------------------------------------------------%
% from Mathematica we get
%-------------------------------------------------------------------------%
Fmatrix(2)=F+(1/2).*ml.*thldot.*((-2).*ldot.*cos(thl)+l.*thldot.*sin( ...
  thl));

Fmatrix(4)=(-1).*g.*(mb+ml)+N+(-1/2).*ml.*thldot.*(l.*thldot.*cos(thl)+ ...
  2.*ldot.*sin(thl));

Fmatrix(6)=tau+(-1).*bhip.*thldot+l.*((-1/2).*ldot.*ml.*thldot+F.*cos( ...
  thl)+(-1/2).*g.*ml.*sin(thl)+N.*sin(thl));

Fmatrix(8)=(-1).*bspring.*ldot+k.*Lspring+l.*((-1).*k+(1/4).*ml.* ...
  thldot.^2)+(1/2).*(g.*ml+(-2).*N).*cos(thl)+F.*sin(thl);
  

%-------------------------------------------------------------------------%
% We add the odd elements
%-------------------------------------------------------------------------%
Fmatrix(1) = xbdot;
Fmatrix(3) = ybdot;
Fmatrix(5) = thldot;
Fmatrix(7) = ldot;


%-------------------------------------------------------------------------%
% Printing
%-------------------------------------------------------------------------%
if ~mod(i2,200)
    clc
    message2 = ['Running time: ',num2str(t),'s /',num2str(tfinal),'s'];
    disp(message2)
end


