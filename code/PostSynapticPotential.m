close all 
clear all
clc

% Generating function that looks like a post-synaptic pulse

%% Log Normal Distribution Function - Looks more like a post synaptic pulse
t = linspace(0,10,100);

% Define parameters - these parameters give the best shape
sigma = 0.5; % sigma must be > 0;
mu = 0; % mu should be b/w -inf, inf

EPSP_func = 1./(t.*sigma.*(sqrt(2.*pi))).*exp(-(log(t - mu).^2)./(2.*sigma.^2));

% Scale vector output to give whatever height wanted

scale_factor = 130; %defines max amplitude in MicroVolts
EPSP = EPSP_func*scale_factor; 

plot(t,EPSP)
xlim([0 10])
ylim([0 150])

hold on

% Generates IPSP pulse - 1/2 magnitude of EPSP and upside down
IPSP = -0.5*EPSP;
plot(t,IPSP)
xlim([0 10])
ylim([-150 150])
title('EPSP & IPSP')
xlabel('Time')
ylabel('Microvolts')
legend('EPSP', 'IPSP')






%% Function with Gaussian distribution (2nd choice to use in case the log-normal distribution is diffiult to use)
t = linspace(0,10,100);

%Gaussian Distribution function: 

a = 3; % controls height of curve
b = 4; % controls location of center peak
c = 1; % controls width of peak

EPSP = a.*exp((-(t-b).^2)./(2.*c.^2));

plot(t, EPSP)
xlim([0 10])
ylim([0 5])

hold on
% Plot of IPSP

IPSP = -0.5*EPSP;
plot(t, IPSP)
xlim([0 10])
ylim([-5 5])

title('EPSP & IPSP')
legend('EPSP', 'IPSP')
xlabel('Time')
ylabel('Microvolts')
legend('EPSP', 'IPSP')

