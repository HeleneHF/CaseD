% Case D

% Parameters
K_p = diag([0.2,0.2,0.1]);
mu = 0.1;
P_d = [2 0; 10,4];   % Row 1: start, Row 2: end
U_ref = 0;  % Case 1
U_max = 0.5;
r = [5; 3];
C = [6; 0];
initial_eta = [1.8 0 0]';
R = diag(r);
R_flip = diag([r(2) r(1)]);
psi_ref = 0;

sim('CaseD.slx');
