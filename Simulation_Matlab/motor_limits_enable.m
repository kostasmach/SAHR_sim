function tau = motor_limits_enable(tau)

% max continuous torque limit
limit_1 = 4.8; 
    
% Hip torque
if tau > limit_1
    tau = limit_1;
elseif tau < -limit_1
    tau = -limit_1;
end


end

