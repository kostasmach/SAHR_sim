%-------------------------------------------------------------------------%
% Plots
%-------------------------------------------------------------------------%

global xdot_des h_des

f2 = figure(2);
set(f2, 'Position', [100, 100, 900, 700]);
clf(f2);
% Background color
set(gcf,'color','w');

% body x velocity
subplot(3,2,1)
plot(t,x(:,2))
hold on
plot([0 t(end)],[xdot_des xdot_des],'-r')
ylabel('Body x Velocity (m/s)') 
xlabel('Time (seconds)') 
% title('Body x Velocity Plot')
grid on

% body height
subplot(3,2,2)
plot(t,x(:,3))
hold on
plot([0 t(end)],[h_des h_des],'-r')
ylabel('Body Height (m)') 
xlabel('Time (seconds)') 
% title('Body Height Plot')
grid on

% body x-y trajectory
subplot(3,2,3)
plot(x(:,1),x(:,3))
ylabel('Body y (m)') 
xlabel('Body x (m)') 
% title('Body x-y Trajectory')
grid on

% leg angle
subplot(3,2,4)
plot(t,rad2deg(x(:,5)))
ylabel('Leg Angle (Degrees)') 
xlabel('Time (seconds)') 
% title('Leg Angle Plot')
grid on

% Spring length
subplot(3,2,5)
plot(t,x(:,7))
ylabel('l (m)') 
xlabel('Time (seconds)') 
% title('l Plot')
grid on

% Actuator torque
subplot(3,2,6)
plot(t,Torques(:))
ylabel('Actuator torque (Nm)') 
xlabel('Time (seconds)') 
grid on

%-------------------------------------------------------------------------%
% Plot Ground Forces
%-------------------------------------------------------------------------%

f3 = figure(3);
set(f3, 'Position', [100, 100, 900, 700]);
clf(f3);
% Background color
set(gcf,'color','w');

% Normal ground force
subplot(2,1,1)
plot(t,Nforce(:))
ylabel('Normal force (N)') 
xlabel('Time (seconds)') 
grid on

% Frictional ground force
subplot(2,1,2)
plot(t,Fforce(:))
ylabel('Frictional force (N)') 
xlabel('Time (seconds)') 
grid on


%-------------------------------------------------------------------------%
% Plot phase portraits
%-------------------------------------------------------------------------%

f4 = figure(4);
set(f4, 'Position', [100, 100, 900, 300]);
clf(f4);
% Background color
set(gcf,'color','w');

% Phase portrait of the body height
subplot(1,3,1)
plot(x(:,3),x(:,4))
ylabel('ybdot (m/s)') 
xlabel('yb (m)') 
grid on

% Phase portrait of the hip angle
subplot(1,3,2)
plot(x(:,5),x(:,6))
ylabel('thldot (rad/s)') 
xlabel('thl (rad)') 
grid on

% Phase portrait of the spring length
subplot(1,3,3)
plot(x(:,7),x(:,8))
ylabel('ldot (m/s)') 
xlabel('l (m)') 
grid on


