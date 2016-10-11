function animation_b()

global step anim_speed
global xout tout

f1 = figure(1);
set(f1, 'Position', [100, 100, 1200, 350]);
clf(f1);

% Stop button to stop animation
stop = uicontrol('style','toggle','string','stop','background','white');

n = size(xout,1);
xb = xout(:,1);
yb = xout(:,3);
thl = xout(:,5);
l = xout(:,7);

% Foot coordinates
xf=xb+l.*sin(thl);
yf=yb+(-1).*l.*cos(thl);

step = 200;

for i = 1:step:n-1

% If stop button is unpressed
if get(stop,'value')==0
    
% Background color
set(gcf,'color','w');


% Plot body (no pitch)
plot(xb(i), yb(i),'o','MarkerSize',20, 'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.9,0.9,0.9])
hold on;
% Plot leg spring
plot([xb(i) xf(i)],[yb(i) yf(i)],':k','LineWidth',2)
% Plot foot
plot(xf(i), yf(i),'o','MarkerSize',3)
% Plot hip
plot(xb(i), yb(i),'o','MarkerSize',8)
% Plot ground
plot([xb(i)-20 xb(i)+20],[0 0],'k','LineWidth',1)


% Moving axis
% axis([xb(i)-0.7 xb(i)+0.7 -0.3 1.1])
axis equal
axis([0 10 -0.5 2.1])


hold off

% Pause between frames
if i < length(tout)
    pause(anim_speed*(tout(i+1) -tout(i)));
end

% Break if Stop button is pressed
elseif get(stop,'value')==1 
        break
end

end

% Turn the stop button into close button
set(stop,'style','pushbutton','string','close','callback','close(gcf)');

end