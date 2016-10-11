function [N, F, slip] = ground_forces(yf, xfdot, yfdot)

global k_ground b_ground
global mu_d mu_s slip_error friction_velocity

%-------------------------------------------------------------------------%
% Normal forces from the ground
%-------------------------------------------------------------------------%
% Flight phase
if yf > 0 
    N = 0;

% Stance phase
else 
    N = k_ground*abs(yf)^1.5 - b_ground*yfdot*abs(yf)^1.5;
end


%-------------------------------------------------------------------------%
% Frictional forces
%-------------------------------------------------------------------------%
% Flight phase
if yf > 0
    F = 0;
    slip  = -1; % indicating slipping in stance phase; no meaning here

% Stance phase
else
    % Calculate slip and stick friction forces
    Fstatic = mu_s * N;
    Fslip   = mu_d * N;
    
    % Determine stick/slip
    if abs(xfdot) <= slip_error % Friction zero crossing
        slip  = 0; % stick
        F = -sign(xfdot)*abs(xfdot)*(Fstatic/slip_error); % stick
    else
        slip  = 1; % slip
        F = -sign(xfdot)*Fslip - sign(xfdot)* ...
        (Fstatic-Fslip)*exp(-abs(xfdot/friction_velocity)+1);
    end

end


end

