%% Aero 560 Final Project Recreation
% Jacob Amezquita
% Christopher Sheehan

clc; clear; close all;

addpath("Functions");

% Constants
I     = eye(3);   
tspan = 200;    % sec

%% Simulate - P2

out = sim('platfor_model.slx');

%% Plot Results - P2

figure()
subplot(2,2,1); hold on;
plot(out.tout, out.q_b_ECI(:,2), out.tout, out.q_b_ECI(:,3), out.tout, out.q_b_ECI(:,4), out.tout, out.q_b_ECI(:,5));
title('Quaternions');
xlabel('Time (sec)'); ylabel('Quat Angles');
legend("\epsilon1", "\epsilon2", "\epsilon3", "\eta");
hold off; grid on;

subplot(2,2,2); hold on;
plot(out.tout, out.E_b_ECI(:,2),out.tout, out.E_b_ECI(:,3),out.tout, out.E_b_ECI(:,4));
title('Euler Angles');
xlabel('Time (sec)'); ylabel('Angle (deg)');
legend("\phi", "\theta", "\psi");
hold off; grid on; 

subplot(2,1,2); hold on;
plot(out.tout, out.w_b_ECI(:,2), out.tout, out.w_b_ECI(:,3), out.tout, out.w_b_ECI(:,4));
title('Angular Velocities');
xlabel('Time (sec)'); ylabel('Angular Velocity (rad/sec)');
legend("\omegax", "\omegay", "\omegaz");
hold off; grid on;

figure()
hold on;
plot(out.tout, out.Omega(:,2), out.tout, out.Omega(:,3), out.tout, out.Omega(:,4), out.tout, out.Omega(:,5));
title('Wheel Velocities in Spin Direction');
ylabel('Angular Velocity (rad/sec)');
xlabel('Time (sec)'); 
legend("\Omega1", "\Omega2", "\Omega3","\Omega4",Location="best");
hold off; grid on;
