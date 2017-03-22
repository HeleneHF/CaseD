close all;

outname = '4-3: ';

eta = output(:,1:3);
eta_d = output(:,4:6);
s = output(:,7);

figure;
subplot(311);
title('x compared to x_d');
plot(0:dt:time, eta(:, 1))
hold on;
plot(0:dt:time, eta_d(:, 1));
legend('x', 'x_d');
xlabel('time');
ylabel('meters');
title([outname 'Idealized and real x,y,psi µ=', num2str(mu)]);

subplot(312);
title('y compared to y_d');
plot(0:dt:time, eta(:, 2))
hold on;
plot(0:dt:time, eta_d(:, 2));
legend('y', 'y_d');
xlabel('time');
ylabel('meters');

subplot(313);
title('\psi compared to \psi_d');
plot(0:dt:time, eta(:, 3)*180/pi)
hold on;
plot(0:dt:time, eta_d(:, 3)*180/pi);
legend('\psi', '\psi_d');
xlabel('time');
ylabel('angle (degrees)');
saveas(gcf, [outname 'Idealized and real x,y,psi µ=', num2str(mu) '.epsc']);

figure;
plot(eta_d(:,1),eta_d(:,2), 'Color', 'Red', 'LineWidth', 5);
hold on;
h = animatedline('Color', 'Black');
old = [output(1,1); output(1,2)];
for k = 1:length(output(:,1))
    addpoints(h,output(k,1),output(k,2));
    if mod(k, 1000) == 0
        new = [output(k,1); output(k,2)];
        diff = new - old;
        if mod(k, 2000) == 0
            quiver(old(1), old(2), diff(1), diff(2), 'LineWidth', 4, 'MaxHeadSize', 4, 'Color', 'Magenta');
        end
        old = [output(k,1); output(k,2)];
    end
    if mod(k, 4000) == 0
        drawnow;
        pause(0.01);
    end
end
drawnow;
title([outname 'Path µ=', num2str(mu)]);
saveas(gcf, [outname 'Path µ=', num2str(mu) '.epsc']);

% Keep this?
if false
% Define figure size
width = 10; % cm
height = 10; % cm
fontsize = 10; % points
x = 20;
y = 20; % Where on the screen the plot will appear, not important.
set(0, 'DefaultTextInterpreter', 'latex') % Interpret (most) text as LaTeX.

% % 4.1.a
%load('log_4.1.a.mat')

% %4.1.b
% load('log_4.1.b.mat')

% %4.2.a
load('log.mat')

eta = ans(2:4,:);
eta_d = ans(5:7,:);
s = ans(8,:);
t = ans(1,:);

% Path in xy-plane
fig = figure(1);
fig.Units = 'centimeters';   %?? -Helene
plot(eta_d(1,:),eta_d(2,:), 'ro');
axis([-5,15,-5,15])
legend('desired position or path')


if true
    h = animatedline;
    for k = 1:length(eta(1,:))
        addpoints(h,eta(1,k),eta(2,k));
        if mod(k, 10000) == 0
            drawnow;
            pause(0.01);
        end
    end
end
    
figure;
plot(simout.time, simout.data(:,3)*180/pi);
hold on;
plot(simout.time, eta_d(3,:)*180/pi);
plot(simout.time, eta(3,:)*180/pi);
axis([0,600,-200,200])
legend('d/dt psi_d', 'psi_d', 'psi');
pause;



% Desired vs measured x-dir
figure
plot(t,eta_d(1,:),'b',t,eta(1,:),'r')
axis([0,inf,0,25])
legend('Desired path','measured position')
title('Desired path x-direction')

% Desired vs measured y-dir
figure
plot(t,eta_d(2,:),'b',t,eta(2,:),'r')
axis([0,500,-inf,inf])
legend('Desired path','measured position')
title('Desired path y-direction')
end
