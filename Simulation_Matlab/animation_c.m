
global step anim_speed
global xout tout xdot_des h_des

f1 = figure(1);
set(f1, 'Position', [50, 70, 1200, 700]);
clf(f1);


n = size(xout,1);
xb = xout(:,1);
xbdot = xout(:,2);
yb = xout(:,3);
thl = xout(:,5);
thldot = xout(:,6);
l = xout(:,7);

% Foot coordinates
xf=xb+l.*sin(thl);
yf=yb+(-1).*l.*cos(thl);

step = 500;

for i = 1:step:n-1
    
% Background color
set(gcf,'color','w');

subplot(3,2,[1 3])

% Plot body (no pitch)
plot(xb(i), yb(i),'o','MarkerSize',50, 'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.9,0.9,0.9])
hold on;
% Plot leg spring
plot([xb(i) xf(i)],[yb(i) yf(i)],':k','LineWidth',2)
% Plot foot
plot(xf(i), yf(i),'o','MarkerSize',3)
% Plot hip
plot(xb(i), yb(i),'o','MarkerSize',10)
% Plot ground
plot([xb(i)-2 xb(i)+2],[0 0],'k','LineWidth',1)



% Plot Force Vectors from the Ground
force_scale = 1000;
% Fore right leg
quiver(xf(i), yf(i), ...
    Fforce(i,1)/(force_scale), Nforce(i,1)/(force_scale),'r')


% Moving axis
axis([xb(i)-0.7 xb(i)+0.7 -0.2 1.2])
axis square

hold off

% % Pause between frames
% if i < length(tout)
%     pause(anim_speed*(tout(i+1) -tout(i)));
% end


subplot(3,2,2)
plot(tout(1:i),xbdot(1:i),'-','LineWidth',1)
hold on
plot([0 tout(end)],[xdot_des xdot_des],'-','LineWidth',1)
hold off
ylabel('Body x Velocity (m/s)') 
xlabel('Time (seconds)') 
axis([0 tout(end) 0.2 0.8])
drawnow
% grid on


subplot(3,2,4)
plot(tout(1:i),yb(1:i),'-','LineWidth',1)
hold on
plot([0 tout(end)],[h_des h_des],'-','LineWidth',1)
hold off
ylabel('Body height (m)') 
xlabel('Time (seconds)') 
axis([0 tout(end) 0 1])
drawnow
% grid on


subplot(3,2,5)
plot(tout(1:i),Torques(1:i),'-','LineWidth',1)
ylabel('Hip Torque (Nm)') 
xlabel('Time (seconds)') 
axis([0 tout(end) -50 30])
drawnow
% grid on


subplot(3,2,6)
plot(tout(1:i),thldot(1:i),'-','LineWidth',1)
ylabel('Hip angular speed (rad/s)') 
xlabel('Time (seconds)') 
axis([0 tout(end) -4 4])
drawnow
% grid on




end


