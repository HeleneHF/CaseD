close all;

eta = output(:,1:3);
eta_d = output(:,4:6);

figure;

plot(eta_d(:,1),eta_d(:,2), 'ro');

h = animatedline;
for k = 1:length(output(:,1))
    addpoints(h,output(k,1),output(k,2));
    if mod(k, 100) == 0
        drawnow;
        pause(0.01);
    end
end

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
