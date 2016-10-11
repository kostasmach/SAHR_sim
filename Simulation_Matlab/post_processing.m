%-------------------------------------------------------------------------%
% Post Processing
%-------------------------------------------------------------------------%

global tfinal

n = size(tout); % data size

%-------------------------------------------------------------------------%
% Initialization of new vectors
%-------------------------------------------------------------------------%
Nforce = [];
Fforce = [];
Slip_events = [];
Torques = [];
Toe_coords = [];

% Initial values for variables and vectors (see dynamics function)
ph = 0; % starting from flight phase
ph_old = 0;
t_prev_stance = [];
long_flight_phases_no = 1; % supposing it starts from flight
flight_phases_no = 1;
fi_desired = 0;


for i_p = 1 : n
  
%-------------------------------------------------------------------------%
% Read the output vector element by element
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
xbi = xout(i_p,1);
xbdoti = xout(i_p,2); 
ybi = xout(i_p,3);
ybdoti = xout(i_p,4);
thli = xout(i_p,5);
thldoti = xout(i_p,6);
li = xout(i_p,7);
ldoti = xout(i_p,8);


%-------------------------------------------------------------------------%
% Read the time vector element by element
%-------------------------------------------------------------------------%  
t_i = tout(i_p);


%-------------------------------------------------------------------------%
% Coordinates and velocities of the foot
%-------------------------------------------------------------------------%
xfi=xbi+li.*sin(thli);
xfdoti=xbdoti+li.*thldoti.*cos(thli)+ldoti.*sin(thli);
yfi=ybi+(-1).*li.*cos(thli);
yfdoti=ybdoti+(-1).*ldoti.*cos(thli)+li.*thldoti.*sin(thli);


%-------------------------------------------------------------------------%
% Save toe coordinates to new vectors (w.r.t. the global frame)
%-------------------------------------------------------------------------%
Toe_coords_i = [xfi yfi];
Toe_coords = [Toe_coords; Toe_coords_i]; 


%-------------------------------------------------------------------------%
% Ground Forces - Recalculating the forces by calling the function
%-------------------------------------------------------------------------%
[Ni, Fi, slipi] = ground_forces(yfi, xfdoti, yfdoti);
%-------------------------------------------------------------------------%
% Save to new vectors
%-------------------------------------------------------------------------%
% Normal ground force
Nforce = [Nforce; Ni];
% Frictional force
Fforce = [Fforce; Fi];
% Slipping vector
Slip_events = [Slip_events; slipi];
% Stance phase events
Stance_events = Slip_events ~= -1;


%-------------------------------------------------------------------------%
% Control Torques - Recalculating torques by calling the function
%-------------------------------------------------------------------------%
[tau, ph_old, t_prev_stance, long_flight_phases_no, ...
    flight_phases_no, fi_desired] = controller(...
    t_i, xbdoti, ybi, ybdoti, thli, thldoti, yfi, ...
    ph_old, t_prev_stance, fi_desired, ...
    long_flight_phases_no, flight_phases_no);

%-------------------------------------------------------------------------%
% Save to new vectors
%-------------------------------------------------------------------------%
Torques = [Torques; tau];


%-------------------------------------------------------------------------%
% Printing
%-------------------------------------------------------------------------%
if ~mod(i_p,200)
    clc
    message2 = ['Post processing time: ',num2str(t_i),'s /',num2str(tfinal),'s'];
    disp(message2)
end


end