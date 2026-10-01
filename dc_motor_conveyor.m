%% Report_2.m  -  DC Motor + Conveyor System (Q1 - Q6)
clear; clc; close all;

%% Q1) DC motor with mechanical part - impulse response (Figure 1.1)
figure;
s = tf('s');
a2 = 1;
a1 = 3.25;
a0 = 0.75;
n  = 0.15;
d  = [a2 a1 a0];
tf1 = tf(n,d);
tf1 = (0.15) / (s^2 + 3.25*s + 0.75);
r = roots(d);
[y,t] = impulse(tf1);
scale = 20 / max(y);
plot(t, y*scale, '', 'LineWidth',0.1)
hold on
yline(20,'r--','Target max speed')
xlabel('Time (s)')
ylabel('Angular speed w(t) [rad/s]')
title('DC Motor with mechanical part')
legend('Dc motor speed response', 'Target max speed')
grid on

%% Q2) Conveyor response to 10 N torque - first order + delay (Figure 2.1)
figure;
s = tf('s');
K = 10;
tau = 1;
tau_d = 2;
n1 = K*10;
d1 = [1 1];
tf1 = exp(-tau_d*s)*tf(n1, d1);
step(tf1)
xlabel('Time (s)');
ylabel('Angular speed (rad/s)');
title('Conveyor response to 10 N torque (First order + delay)');
grid on

%% Q3) Periodic speed rise effect - gear defect (Figure 3.1)
figure;
s = tf('s');
G = (0.15)/(s^2 + 3.25*s + 0.75);
[y, t] = impulse(G);
y = cumtrapz(t, y);
y = 20*y/max(y);
y_dist = y - 2*floor(t/2);
figure;   
plot(t, y,'b--','LineWidth',1.5)
hold on;
plot(t, y_dist,'r-','LineWidth',2)
title('Periodic Speed Rise Effect');
xlabel('Time (s)');
ylabel('Angular speed (rad/s)');
legend('Normally','Disturbed');
grid on;

%% Q4) Conveyor response ideal vs disturbed (Figure 4.1)
figure;
s = tf('s');
K = 10;
tau = 1;
tau_d = 2;
d1 = [1 1];
n1_i = K * 10;
n1_di = K * 9;
tf_i = tf(n1_i, d1, 'delay', tau_d);
tf_di = tf(n1_di, d1, 'delay', tau_d);
figure;   
step(tf_i, 'b--', tf_di, 'r-');
xlabel('Time (s)');
ylabel('Angular speed(rad/s)');
title('Conveyor response ideal vs disturbed');
legend('Ideal response SS 1.0 rad/s', 'Disturbance response SS 0.9 rad/s');
grid on;


%% Q6) Open loop step response, Kp = 0.75 (Figure 6.1)
s = tf('s');
Kp = 0.75;
Gm = (0.15) / (s^2 + 3.25*s + 0.75);
Gc = (10) * exp(-2*s)/(s + 1);
n = 10;
d = [1 1];
Gc = tf(n , d, 'InputDelay', 2);
G_OL = Kp * Gm * Gc;
figure
step(G_OL)
title('Open Loop Step Response Kp = 0.75')
ylabel('Angular speed (rad/s)')
xlabel('Time (s)')
yline(15, 'r--', 'Target speed = 15 rad/s')
grid on