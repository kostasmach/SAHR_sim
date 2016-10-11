===========================================================================
General info
===========================================================================
2d Simulation of our Single Actuator Hopping Robot SAHR
Created by Konstantinos Machairas (kmach@central.ntua.gr) - 10/2016
Personal page: http://www.kmachairas.com
Lab page: http://csl-ep.mech.ntua.gr

Dynamics were derived with Mathematica
Mathematica file:"2 dof_single_legged_robot.nb"



===========================================================================
User Guide (with default options)
===========================================================================
Run main.m
- the simulation will run for 25 seconds (see time in command window)
- a first animation will run
- a postprocessing script will run (see time in command window)
- a second animation with more info will run
- results will appear in various figures

Modify main.m to set:
- different initial conditions
- different robot parameters
- different simulation time
- different ode solver or different solver parameters
- different ground properties

Comment out the corresponding lines in main.m to run only the 
functions you want after simulation is over. 

Modify controller.m to try different locomotion scenarios.

The controller used here can be found in:
Vasilopoulos, V., Paraskevas, I., and Papadopoulos, E., “All-terrain Legged 
Locomotion Using a Terradynamics Approach,” Proc. of the 2014 International 
Conference on Intelligent Robots and Systems (IROS '14), Chicago, Illinois, 
Sept. 14–18, 2014, USA



===========================================================================
Scripts and Functions described
===========================================================================

---------------------------------------------------------------------------
main.m
---------------------------------------------------------------------------
Run this script to start the simulation. By default you don't need to run
any other scripts; results will appear automatically.

Settings for:
- model parameters
- initial conditions
- ground properties
- solver parameters

Functions called: 
- mass.m
- dynamics.m
- post_processing.m
- animation_a.m
- animation_b.m
- animation_c.m
- animation_video.m
- plots.m


---------------------------------------------------------------------------
mass.m
---------------------------------------------------------------------------
Returns the mass matrix M of the Equations of Motion (EoM), described in 
the form: M(x,x') * x' = F(x,x').


---------------------------------------------------------------------------
dynamics.m
---------------------------------------------------------------------------
Returns the F matrix of the Equations of Motion (EoM), described in the
form: M(x,x') * x' = F(x,x'). The function prints running time in 
the command window.

Functions called: 
- ground_forces.m
- controller.m


---------------------------------------------------------------------------
ground_forces.m
---------------------------------------------------------------------------
Returns normal forces and frictional forces from the ground as well as 
four variables (slipFR, slipHR, slipFL, slipHL) that indicate whether 
a toe slipped. A typical compliant Hunt-Crossley model is used for the 
normal ground forces, and a simple model that predicts slipping and 
sticking for the frictional forces (see friction_model.m).


---------------------------------------------------------------------------
friction_model.m
---------------------------------------------------------------------------
A script used only for visualization of the friction model, and not used
in simulation. Run the script to get a frictional force - velocity plot.


---------------------------------------------------------------------------
controller.m
---------------------------------------------------------------------------
Runs the controller. Modify this function to generate different gait 
scenarios. The control scheme used is the one described in:

Vasilopoulos, V., Paraskevas, I., and Papadopoulos, E., “All-terrain Legged 
Locomotion Using a Terradynamics Approach,” Proc. of the 2014 International 
Conference on Intelligent Robots and Systems (IROS '14), Chicago, Illinois, 
Sept. 14–18, 2014, USA

Functions called:
- td_angle_controller.m
- motor_limits_enable.m


---------------------------------------------------------------------------
td_angle_controller
---------------------------------------------------------------------------
Returns the desired hip angle.



---------------------------------------------------------------------------
motor_limits_enable.m
---------------------------------------------------------------------------
Puts limits on the actuator's torque.


---------------------------------------------------------------------------
post_processing.m
---------------------------------------------------------------------------
Many variables are not saved during simulation. Run the script after 
simulation is over to get all the results (ground forces, control torques
etc) based on the simulation results. The script prints processing time 
in the command window. It may take a while.

Functions called:
- ground_forces.m
- controller.m


---------------------------------------------------------------------------
animation_a.m, animation_b
---------------------------------------------------------------------------
You can run these scripts before post_processing.m as they only animate the 
motion with minimum information.


---------------------------------------------------------------------------
animation_c.m
---------------------------------------------------------------------------
Run this script only after post_processing has run. It shows an animation 
with more data than animation.m.


---------------------------------------------------------------------------
animation_video.m
---------------------------------------------------------------------------
Run this script only after post_processing and if you want to save frames 
to make a video out of them (using another software e.g. Adobe Premiere).


---------------------------------------------------------------------------
plots.m
---------------------------------------------------------------------------
This script runs all the scripts located in the plot_functions folder, and
produces plots with all the results available.

