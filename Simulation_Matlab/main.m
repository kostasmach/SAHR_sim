%-------------------------------------------------------------------------%
% Simulation and animation of a 2 dof legged robot with 1 springy leg (no
% body pitch)
% Dynamics derived with Mathematica 
% Mathematica file:"2 dof_single_legged_robot"
% Created by Konstantinos Machairas (kmach@central.ntua.gr) - 10/2016
% Web: http://www.kmachairas.com
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
% Enable/ Disable EOM solving, amimation
%-------------------------------------------------------------------------%
clear global; clear all; clc;
solve_EOM = true; % enable ODE solving
anim = true; % enable animation


%-------------------------------------------------------------------------%
% Define physical parameters of the system
%-------------------------------------------------------------------------%
global mb ml Il g k Lspring  
global bhip bspring
global k_ground b_ground
global mu_s mu_d slip_error friction_velocity
global xout tout
global ph ph_old
global t_prev_stance
global long_flight_phases_no
global flight_phases_no
global fi_desired
global tfinal
global i2

% Body mass and inertia
mb = 6;

% Leg
ml = 0.2; % leg mass
Il = 0.01; % leg MoI
k = 5000; % spring constant
Lspring = 0.5; % spring length

% Energy losses at dofs
bhip = 0.01; % hip dof
bspring = 3; % prismatic (spring) dof

% Hunt - Crossley model for contact with the ground
k_ground = 200000;
b_ground = 0.05*k_ground;

% Friction Model
mu_s = 1.5;
mu_d = 1.4;
slip_error = 0.01; % velocity transition to stick
friction_velocity = 0.01; % Stiction velocity

% Gravity
g = 9.81;
% g = 0;

% Simulation duration
tstart = 0;
tfinal = 25;

% Initial values for variables and vectors (see dynamics function)
ph = 0; % starting from flight phase
ph_old = 0;
t_prev_stance = [];
long_flight_phases_no = 1; % supposing it starts from flight
flight_phases_no = 1;
fi_desired = 0;
i2 = 0; % counter used in dynamics function


%-------------------------------------------------------------------------%
% Solve the Equations of Motion
%-------------------------------------------------------------------------%
if solve_EOM == true
    
%-------------------------------------------------------------------------%
% Matrix form: M(x,x') * x' = F(x,x')
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

% Set initial conditions
xb_0 = 0;
xb_dot_0 = 0.3; 
yb_0 = Lspring + 0.5;
yb_dot_0 = 0;
thl_0 = 0;
thl_dot_0 = 0;
l_0 = Lspring;
l_dot_0 = 0;

% Vector of initial conditions.
x0 = [xb_0, xb_dot_0, yb_0, yb_dot_0, thl_0, ...
    thl_dot_0, l_0, l_dot_0];

% Options for ODE
% options = odeset('Mass',@mass); 
options = odeset('MaxStep',1e-4,'AbsTol',1e-7,'RelTol',1e-7,'Mass',@mass);

% Set the time interval
tspan = [tstart tfinal];
% tspan = linspace(tstart,tfinal,100000);

% Solve ODE
[t,x] = ode15s(@dynamics,tspan,x0,options);

% Save the results
xout = x; 
tout = t;

end

%-------------------------------------------------------------------------%
% Animation
%-------------------------------------------------------------------------%
% Check if it is enabled
if anim == true 
    
    % Check if there are data for animation
    if ~exist('x') 
        disp('no data for animation')
    else
        %animation_a()
        animation_b()
    end
    
end


%-------------------------------------------------------------------------%
% Post Processing
%-------------------------------------------------------------------------%
post_processing


%-------------------------------------------------------------------------%
% Animation
%-------------------------------------------------------------------------%
animation_c


%-------------------------------------------------------------------------%
% Plots
%-------------------------------------------------------------------------%
plots


