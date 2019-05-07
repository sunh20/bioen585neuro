%% BIOEN585 Final Project: Neuro group
% 20190507
% some starter code

clear all; close all; clc;

% izhikevich simple model

% parameters
a = 0.02;   % time scale of recovery u
b = 0.2;    % sensitivity of recovery
c = -65;    % mV, post spike reset for v
d = 8;      % post spike reset for u
maxSpike = 30; % threshold potential
I = 0;      % input 
params = [I, a, b, c, d, maxSpike];

% variables - initial conditions

v_0 = c;
u_0 = d;
y = [v_0,u_0];

% ode




