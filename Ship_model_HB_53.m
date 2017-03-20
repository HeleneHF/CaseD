
% Case B
% TASK 1 THEORY PART:

%% Parameters
% Rigid body and added mass
m = 14.79; 
I_z = 1.76; 
x_g = 0.0375; 
y_g = 0.0; 

X_u_dot = -2; 
Y_v_dot = -10; 
Y_r_dot = -0; 
N_r_dot = -1; 

% Max Values in Surge X, Sway Y and Yaw N
X_max = 1.03; %[N]
N_max = 2.50; %[N]
Y_max = 0.98; %[N]

% Hydro surge, Hydro sway and Hydro Yaw Parameters
    % NB! We don't need most of them for now, that why they are commented
    % out, but don't remove them!!
X_u = -0.6555;  Y_v = -1.33;    N_v = 0.0; 
X_uu = 0.3545;  Y_vv = -2.776;  N_vv = -0.2088; 
X_uuu = -3.787; Y_vvv = -64.91; N_vvv = 0.0;
X_v = 0.0;      Y_r = -7.25;    N_r = -1.9; 
X_vv = -2.443;  Y_rr = -3.45;   N_rr = 0.75;
X_vvv = 0.0;    Y_rrr = 0.0;    N_rrr = 0.0;
                Y_rv = 0.805;   N_rv = 0.130;
                Y_vr = -0.845;  N_vr = 0.080;

%% Matrixes
    % NBB! 
    u = 1; v = 1; r = 1; % I need a test values; 
    
% Vessel Inertia Matrix
a_11 = m-X_u_dot;   a_12 = 0;                   a_13 = 0; 
a_21 = 0;           a_22 = m-Y_v_dot ;          a_23 = m*x_g - Y_r_dot;
a_31 = 0;           a_32 = m*x_g - Y_r_dot;     a_33 = I_z - N_r_dot;

M = [a_11 a_12, a_13; a_12 a_22 a_23; a_31 a_32 a_33];

% The damping matrix
d_11_u = -X_u - X_uu*abs(u) - X_uuu*u^2;
d_22_vr = -Y_v -Y_vv*abs(v) - Y_vvv*v^2 - Y_rv*r^2;
d_23_vr = -Y_r - Y_vr*abs(v) - Y_rr*abs(r) - Y_rrr*r^2;
% d_32_vr = -N_v - N_vv*abs(v) - N_vvv*v^2 - N_rv*abs(r);
% d_33_vr = -N_r - N_vr*abs(v) - N_rr*abs(r) - N_rrr*r^2;

% The total damping matrix from the handbook page 53
D_tot = [d_11_u 0 0; 0 d_22_vr 0; 0 d_32_vr d_33_vr];

% The simplified damping matrix we use in the model Task 1 Case B
D_simp = d_11_u;

% Coreolis and centripidal matrix
    % NB! Not used in the simplifies model. Taken from page 53 in HB
c_11 = 0;                           c_12 = m*r;         c_13 = Y_v_dot*v + (Y_r_dot + m*x_g)*r;
c_21 = m*r;                         c_22 = 0;           c_23 = -X_u_dot*u;
c_31 = -Y_v_dot*v-(Y_r_dot-m*x_g)*r;c_32 = X_u_dot*u;   c_33 = 0;

C = [c_11 c_12 c_13; c_21 c_22 c_23; c_31 c_32 c_33]; % Full matrix