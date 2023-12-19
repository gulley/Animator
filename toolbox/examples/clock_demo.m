% What time is it?
t = linspace(0,2*pi,100);
plot(cos(t),sin(t),'k')

% Draw the clock face
for n = 1:12
    ang = pi/2 - n*2*pi/12;
    text(0.9*cos(ang),0.9*sin(ang),num2str(n), ...
        HorizontalAlignment="center", ...
        VerticalAlignment="middle")
end

set(gcf,Color="white")
axis equal
axis off
axis([-1 1 -1 1])

hr_hand  = line([0 0],[0 1],LineWidth=6);
min_hand = line([0 0],[0 1],LineWidth=2);

%%
% What time is it?
t = 3.5;                                              % 1 .. 3

% Draw the hands
m = 60*(t - floor(t));
min_angle = pi/2 - m/60*2*pi;
hr_angle  = pi/2 - t/12*2*pi;

set(hr_hand, XData=[0  0.5*cos(hr_angle)],YData=[0  0.5*sin(hr_angle)])
set(min_hand,XData=[0 0.8*cos(min_angle)],YData=[0 0.8*sin(min_angle)])
