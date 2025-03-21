%% Aero 560 Final Project Recreation
% Jacob Amezquita
% Christopher Sheehan

clc; clear; close all;

addpath("Functions");

% Constants
I     = eye(3);   
tspan = 60;    % sec

%% Initial Conditions

% Initial inertia - Given (Assumed not with wheels)
J_pl  = [0.1614 -0.0015 0.0041;
        -0.0015 0.1547 -0.0001;
        0.0041 -0.0001 0.2828];

% Initial Euler angles
E_b_0 = [0; 0; 0]; % radians

% Initial angular velocity
w_b_0 = [0; 0; 0]; % rad/s

%% Rxn Wheel Characteristics

% 3-axis
num_w  = 3;    % number of wheels
m_w    = .2;   % kg
radi_w = 0.08; % m
hei_w  = 0.02; % m
pos_w  = 0.4;  % m, distance from bus center

% Rxn wheel inertia
Inrt_s = 0.5*m_w*radi_w^2;                       % kg*m^2, inertia
Inrt_t = 0.25*m_w*radi_w^2 + (1/12)*m_w*hei_w^2; % kg*m^2, inertia
Inrt_g = Inrt_t;
I_w = [Inrt_s  0     0;
         0   Inrt_t  0;
         0     0   Inrt_g];

% Inertia along spin axis of each wheel 
I_ws = [];
for i = 1:num_w
    I_wi = I_w(1,1);
    I_ws = blkdiag(I_ws, I_wi); % Append to block diagonal matrix
end 

% Alignment of 3 axis to body
A_s = [1 0 0;
       0 1 0;
       0 0 1];
A_g = [0 0 1;
       1 0 0;
       0 1 0];
A_t = cross(A_g,A_s);

%% Wheel to Body Inertia

% Wheel space to body frame
pos_b_w = pos_w*[1  0 -1  0;
                 0  1  0 -1;
                 0  0  0  0];
I_b_w_1 = m_w*vectCross(pos_b_w(:,1))*vectCross(pos_b_w(:,1));
I_b_w_2 = m_w*vectCross(pos_b_w(:,2))*vectCross(pos_b_w(:,2));
I_b_w_3 = m_w*vectCross(pos_b_w(:,3))*vectCross(pos_b_w(:,3));
I_b_w_4 = m_w*vectCross(pos_b_w(:,4))*vectCross(pos_b_w(:,4));

I_b = J_pl - I_b_w_1 - I_b_w_2 - I_b_w_3 - I_b_w_4;
J   = I_b + A_s*Inrt_s*A_s' + A_t*Inrt_t*A_t' + A_g*Inrt_g*A_g';

%% Control Law Gains

% Control gains
zeta = 0.70; % damping coefficient
t_s  = 4;    % sec, settling time

% w_n = 4.4/(t_s*zeta);
w_n  = log(0.02*sqrt(1-zeta^2))/-zeta/t_s;

% beta = atan(sqrt(1-zeta^2)/zeta);
% tr = (pi-beta)/w_n/sqrt(1-zeta^2);

% Extend to each Axis
k_p = (2*J.*w_n^2);    % kg*m^2 / s^2 = N-m
k_d = (J.*2*zeta*w_n); % kg*m^2 / s^2 = N-m

% Initial no torque                   
T = [0;0;0]; % N-m

%% Print Output

disp(' ')
disp("---Final Project Sim Inputs---")

fprintf('The allignement A_s to each body axis is: \n');
disp(A_s)
fprintf('The allignement A_t to each body axis is: \n');
disp(A_t)
fprintf('The allignement A_g to each body axis is: \n');
disp(A_g)

fprintf('The inertia of the body I_b is: \n');
disp(I_b)
fprintf('The inertia of the spacecraft is: \n');
disp(J)

fprintf('The control gain k_p extended to each axis is: \n');
disp(k_p)
fprintf('The control gain k_d extended to each axis is: \n');
disp(k_d)

%% Simulate

out = sim('platform_model.slx');

%% Plot Results

figure()
subplot(3,1,1); hold on;
plot(out.tout, out.E_b_ECI(:,2),out.tout, out.E_b_ECI(:,3),out.tout, out.E_b_ECI(:,4));
title('Euler Angles'); 
ylabel('Angle (deg)');
legend("\phi", "\theta", "\psi",Location="eastoutside");
hold off; grid on; 

subplot(3,1,2); hold on;
plot(out.tout, out.w_b_ECI(:,2), out.tout, out.w_b_ECI(:,3), out.tout, out.w_b_ECI(:,4));
title('Angular Velocities');
ylabel('Angular Velocity (rad/sec)');
legend("\omegax", "\omegay", "\omegaz",Location="eastoutside");
hold off; grid on;

subplot(3,1,3); hold on;
plot(out.tout, out.Omega(:,2), out.tout, out.Omega(:,3), out.tout, out.Omega(:,4));
title('Wheel Velocities in Spin Direction');
xlabel('Time (sec)'); ylabel('Angular Velocity (rad/sec)');
legend("\Omega1", "\Omega2", "\Omega3",Location="eastoutside");
hold off; grid on;

figure()
subplot(2,1,1);hold on;
plot(out.tout, out.w_C(:,2), out.tout, out.w_C(:,3), out.tout, out.w_C(:,4));
title('Wheel Velocities in Spin Direction');
ylabel('Angular Velocity (rad/sec)');
legend("\Omega1", "\Omega2", "\Omega3",Location="eastoutside");
hold off; grid on;

subplot(2,1,2);hold on;
plot(out.tout, out.T_dist(:,2), out.tout, out.T_dist(:,3), out.tout, out.T_dist(:,4));
title('Disturbance Troque Applied');
xlabel('Time (sec)'); ylabel('Torque (N-m)');
ylim([-0.05 0.02]);
legend("\tau1", "\tau2", "\tau3",Location="eastoutside");
hold off; grid on;