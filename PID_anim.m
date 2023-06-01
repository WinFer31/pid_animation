% Credits: Panchenko Dmitriy (D.Panchenko@stud.satbayev.university)

% load system to workspace
load_system('model');

% define time of animation
delay = 0.1;

% define final values
final_P = 0.343;
final_I = 0.1;
final_D = 1.5;

P = linspace(1, final_P, 20);
I = linspace(0, final_I, 20);
D = linspace(0, final_D, 20);

set_param('model/P1', 'Gain', '1');
set_param('model/I1', 'Gain', '0');
set_param('model/D1', 'Gain', '0');

% axis equal
% axis([0,70,0,2])
ax = gca;
ax.NextPlot = 'replaceChildren';
    
loops = 20;

F(loops) = struct('cdata',[],'colormap',[]);

for j = 1:loops
set_param('model/P1', 'Gain', num2str(P(j)));
sim('model')

plot(Y)

title(['K_p = ' num2str(round(P(j), 1)), '\newline' 'K_I = ' num2str(I(1)), '\newline' 'K_D = ' num2str(D(1))])
drawnow
F(j) = getframe(gcf);
pause(delay)
end

for j = 1:loops
set_param('model/I1', 'Gain', num2str(I(j)));
sim('model')
plot(Y)
title(['K_p = ' num2str(P(loops)), '\newline' 'K_I = ' num2str(round(I(j), 1)), '\newline' 'K_D = ' num2str(D(1))])
drawnow
F(j) = getframe(gcf);
pause(delay)
end

for j = 1:loops
set_param('model/D1', 'Gain', num2str(D(j)));
sim('model')
plot(Y)
title(['K_p = ' num2str(P(loops)), '\newline' 'K_I = ' num2str(I(loops)), '\newline' 'K_D = ' num2str(round(D(j), 1))])
drawnow
F(j) = getframe(gcf);
pause(delay)
end