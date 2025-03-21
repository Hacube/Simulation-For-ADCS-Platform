%% msd_init.m
% Initialize workspace for the MSD Kalman Filter assignment.

clear; clc; close all;

% --- System parameters ---
omega_n = 2.0;   % Natural frequency (rad/s)
zeta    = 0.7;   % Damping ratio
noise   = 0;

% Continuous-time state-space matrices
A = [ 0                1
     -omega_n^2   -2*zeta*omega_n ];
B = [0
     1];
C = [1 0];

D = 0;

% Sample time for discrete system
Ts = 0.1;

% Discretize the continuous system
sysC = ss(A, B, C, D);
sysD = c2d(sysC, Ts, 'zoh');
[A_d, B_d, C_d, D_d] = ssdata(sysD);

% Process noise covariance (discrete)
Q = eye(2) * 0.01;  
% Measurement noise covariance
R = 1;

% Initial conditions
x0_cont = [0.05; -0.01];  % continuous initial condition
x0_disc = x0_cont;        % same initial condition used in discrete

% Simulation time
tFinal = 25;

%%

% 2) Run scenario (a) - no noise
disp('Running scenario (a) - continuous no noise');
sim('h6p12.slx');

true = ans.simout.Data;
tout = ans.tout;

% The output is in logsout or you can connect signals to "To Workspace" blocks.
% Plot results:
figure; 
plot(tout, true, 'LineWidth',2);
title('Scenario (a) - No Noise');
xlabel('Time (s)'); ylabel('Position (m)');

%%

noise   = 1;

% 3) Run scenario (b) - continuous with noise
disp('Running scenario (b) - continuous with noise');
sim('h6p12.slx');

noisy = ans.simout.Data;

figure;
plot(tout, true, 'b', 'LineWidth',2); hold on;
plot(tout, noisy, 'r-', 'LineWidth',1);
title('Scenario (b) - With Noise');
legend('True Position','Noisy Measurement');
xlabel('Time (s)'); ylabel('Position (m)');

%%

% 4) Run scenario (c) - discrete + Kalman Filter
disp('Running scenario (c) - discrete + Kalman Filter');
sim('h6p3.slx');

measured = ans.measured.Data;
filtered = squeeze(ans.filtered.Data(1,:,:));

figure;
plot(tout, true, 'b', 'LineWidth',1); hold on;
plot(tout, measured, 'r-', 'LineWidth',1);
plot(tout, filtered, 'k-', 'LineWidth',2);
title('Scenario (c) - Kalman Filter');
legend('True Position','Noisy Reading', 'Kalman Estimate');
xlabel('Time (s)'); ylabel('Position (m)');

