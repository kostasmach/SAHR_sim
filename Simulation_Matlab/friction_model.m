%-------------------------------------------------------------------------%
% This file describes the friction model used by giving a F-v plot
% It is only useful for checking which frictional model is used
%-------------------------------------------------------------------------%

global mu_s mu_d slip_error friction_velocity

hold all
i=1;
F_friction = [];
N = 200;
    
% mu_s = 1.5;
% mu_d = 1.4;
% slip_error = 0.01;            % velocity transition to stick
% friction_velocity = 0.01;      % Stiction velocity

for v=-2:0.001:2

    % Calculate slip and stick friction forces
    Fstatic = mu_s * N;
    Fslip   = mu_d * N;
    
    % Determine stick/slip
    if abs(v) <= slip_error % Friction zero crossing
        slip  = 0; % stick
        Ffr = -sign(v)*abs(v)*(Fstatic/slip_error); % stick
    else
        slip  = 1; % slip
        Ffr = -sign(v)*Fslip - sign(v)* ...
        (Fstatic-Fslip)*exp(-abs(v/friction_velocity)+1);
    end
    
    F_friction(i) = Ffr;
    vel(i) = v;
    i=i+1;
end

plot(vel,F_friction,'-')



    
    