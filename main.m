%% Aero 560 Final Project Recreation
% Jacob Amezquita
% Christopher Sheehan

clc; clear; close all;

addpath("Functions");

% Constants
I     = eye(3);   
tspan = 60;    % sec

%% Control Law Gains - P2

% Control gains
zeta = 0.70; % damping coefficient
t_s  = 70;   % sec, settling time

% w_n = 4.4/(t_s*zeta);
w_n  = log(0.02*sqrt(1-zeta^2))/-zeta/t_s;

% beta = atan(sqrt(1-zeta^2)/zeta);
% tr = (pi-beta)/w_n/sqrt(1-zeta^2);

% Extend to each Axis
k_p = (2*J.*w_n^2);    % kg*m^2 / s^2 = N-m
k_d = (J.*2*zeta*w_n); % kg*m^2 / s^2 = N-m

% Initial no torque                   
T = [0;0;0]; % N-m


%% Simulate - P2

% out = sim('platfor_model.slx');

%% Plot Results - P2

% figure()
% subplot(2,2,1); hold on;
% plot(out.tout, out.q_b_ECI(:,2), out.tout, out.q_b_ECI(:,3), out.tout, out.q_b_ECI(:,4), out.tout, out.q_b_ECI(:,5));
% title('Quaternions');
% xlabel('Time (sec)'); ylabel('Quat Angles');
% legend("\epsilon1", "\epsilon2", "\epsilon3", "\eta");
% hold off; grid on;
% 
% subplot(2,2,2); hold on;
% plot(out.tout, out.E_b_ECI(:,2),out.tout, out.E_b_ECI(:,3),out.tout, out.E_b_ECI(:,4));
% title('Euler Angles');
% xlabel('Time (sec)'); ylabel('Angle (deg)');
% legend("\phi", "\theta", "\psi");
% hold off; grid on; 
% 
% subplot(2,1,2); hold on;
% plot(out.tout, out.w_b_ECI(:,2), out.tout, out.w_b_ECI(:,3), out.tout, out.w_b_ECI(:,4));
% title('Angular Velocities');
% xlabel('Time (sec)'); ylabel('Angular Velocity (rad/sec)');
% legend("\omegax", "\omegay", "\omegaz");
% hold off; grid on;
% 
% figure()
% hold on;
% plot(out.tout, out.Omega(:,2), out.tout, out.Omega(:,3), out.tout, out.Omega(:,4), out.tout, out.Omega(:,5));
% title('Wheel Velocities in Spin Direction');
% ylabel('Angular Velocity (rad/sec)');
% xlabel('Time (sec)'); 
% legend("\Omega1", "\Omega2", "\Omega3","\Omega4",Location="best");
% hold off; grid on;
