function animation_a()

global step anim_speed
global xout tout

f1 = figure(1);
set(f1, 'Position', [100, 100, 900, 700]);
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

step = 120;

for i = 1:step:n-1

% If stop button is unpressed
if get(stop,'value')==0
    
% Background color
set(gcf,'color','w');


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


% Moving axis
axis([xb(i)-0.7 xb(i)+0.7 -0.2 1.2])
axis square

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