function [tau, ph_old, t_prev_stance, long_flight_phases_no, ...
    flight_phases_no, fi_desired]= controller(...
    t, xbdot, yb, ybdot, thl, thldot, yf, ...
    ph_old, t_prev_stance, fi_desired, ...
    long_flight_phases_no, flight_phases_no)

global Lspring
% global t_prev_stance
% global t_prev_stance_history
% global long_flight_phases_no
% global flight_phases_no
% global fi_desired
global xdot_des h_des

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

% Desired body velocity
xdot_des = 0.5;
% Desired body apex height
h_des = 1.05*Lspring;

% Current hip angle (relative to the body)
current_fi = thl;

% Current hip angle time derivative (relative to the body)
current_fi_dot = thldot;


% Identifying Phases - Saving data from previous cycle
if yf > 0    
    ph = 0; % Flight Phase    
else  
    % Stance phase (whenever the toe touches the ground)
    ph = 1; 
end


% Flight phase
if ph == 0
    
    % Identify the start of a flight phase, by checking the previous phase
    if ph_old == 1 
        
        % Checking the length of the time vector to avoid saving data for
        % very short stance phases
        if length(t_prev_stance) > 100           
            
            % Calculate the time of the previous long stance
            dt_stance = t_prev_stance(end) - t_prev_stance(1);
            
            % Clear t_prev_stance_history to be ready 
            % for the next stance phase
            t_prev_stance = [];        
        
            % Save body y at lift off 
            y_lo = yb;
                        
            % Save body y velocity at lift off 
            y_dot_lo = ybdot;
           
            % Counting long flight phases
            long_flight_phases_no = long_flight_phases_no + 1;
            
            % Choose the desired hip angle
            if long_flight_phases_no < 4
                fi_desired = deg2rad(5);
            else
                fi_desired = td_angle_controller(h_des, xdot_des, ...
                    dt_stance, y_lo, y_dot_lo);
            end
            
%         else
%             % Clear t_prev_stance_history to be ready 
%             % for the next stance phase
%             t_prev_stance = [];
            
        end
                    
        % Counting flight phases
        flight_phases_no = flight_phases_no + 1; 
        
    end
    
    % Drive the leg to the desired angle
    Kp = 60;
    Kv = 5;
    tau = - Kp * (current_fi - fi_desired) - Kv * current_fi_dot;  
        
% Stance phase        
elseif ph == 1
    
    % Fill a matrix with time t during stance (a value is added in 
    % every iteration)
    t_prev_stance = [t_prev_stance; t];
    
    % Forward velocity controller
    k_stance = 100;
    tau = k_stance*(xbdot-xdot_des);
         
end



% Enable Actuators Limits - Uncomment to enable
% tau = motor_limits_enable(tau);



% Save old phase flight/stance
ph_old = ph;

%[fi_desired, long_flight_phases_no]
% [length(t_prev_stance) , long_flight_phases_no]


