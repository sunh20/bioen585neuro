%% BIOEN585 Final Project: Neuro group
% 20190507
% some starter code

clear all; close all; clc;

% izhikevich simple model

% model coefficients
% from paper: 0.04*v^2 + 5*v + 140
% can change this to the format in the book
A = 0.04;
B = 5;
C = 140;

% parameters
a = 0.02;   % time scale of recovery u
b = 0.2;    % sensitivity of recovery
c = -65;    % mV, post spike reset for v
d = 8;      % post spike reset for u
maxSpike = 30; % max spike potential

% time
dt = 0.01;
t = 0:dt:100; % time span (units?)

% inputs - uncomment the input you want
I = zeros(length(t),1);

% input 1: +40 mV square pulses 
    I(500:1000) = 40;  % +40 mV square pulse
    I(2500:3000) = 40;  % +40 mV square pulse
    I(4500:5000) = 40;  % +40 mV square pulse
    I(6500:7000) = 40;  % +40 mV square pulse
    I(8500:9000) = 40;  % +40 mV square pulse
    
% input 2: random noise [0 100]
    % I = rand(size(I)).*100;

% variables
u = zeros(length(t),1);
v = zeros(length(t),1);
u(1) = d;   % ICs
v(1) = c;   % ICs

% ode - manually step through using Forward Euler
for idx = 1:length(t)-1
    % if reaches max spike potential
    if v(idx) >= maxSpike
        fprintf('Max spike reached at t=%.2f\n',idx*dt)
        v(idx) = maxSpike; % makes sure spikes don't exceed this
        v(idx+1) = c;
        u(idx+1) = u(idx) + d;
    else      
        % ODE: next = current + dt * dy/dt
        u(idx+1) = u(idx) + dt * (a * (b*v(idx) - u(idx)));
        v(idx+1) = v(idx) + dt * (A*v(idx)^2 + B*v(idx) + C - u(idx) + I(idx));
    end
end

% ode - using ode solver (doesn't work because you can't assign variables
%                           directly i.e. when v -> -65, can potentially
%                           be implemented using Events options
% [t,y] = ode45(@simpleIZ,tspan,IC,[],params);

% plot time repsonse vs. input
figure;

ax1 = subplot(2,1,1);
plot(t,v,t,u)
title('Voltage time response of Izhikevich simple model')

ax2 = subplot(2,1,2);
plot(t,I)
title('Input function')

linkaxes([ax1 ax2],'xy')



