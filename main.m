% Case D
for mu_n = [0 0.1 1 10]
    time = 100;
    dt = 0.01;
    points = length(0:dt:time);
    % Parameters
    K_p = diag([0.2,0.2,0.1]);
    mu = mu_n;
    P_d = [2  0; 
           10 4];
    U_ref = [(0:dt:time)' [zeros(floor(1*points/6),1);
                           ones(ceil(4*points/6),1)*0.1;
                           zeros(floor(1*points/6)+1,1)]];  % Case 1
    U_max = 1;
    r = [5; 3];
    C = [6; 0];
    initial_eta = [1 0 0]';
    initial_eta_2 = [6 5 0]';
    initial_eta_4 = [7 0 0]';
    R = diag(r);
    R_flip = diag([r(2) r(1)]);
    psi_ref = 0;

    sim('CaseD.slx');
end
