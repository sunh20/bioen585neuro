function genFigures()
% generates all figures for this project
% does not rely on parameters so can run by section

%% Figure 1: borrowed from Izhikevich 2003 paper

%% Figure 2: Simple IZ neuron with step input

dt = 0.01;
t = 0:dt:100; % time span (ms)
I = zeros(length(t),1);

% input
I(1000:end) = 40;    % +40 mV square pulse

simpleIZ(t,dt,I)

%% Figure 3: Averaged extracellular potential neuron
load('neuron2.mat')

plot(t*1e3, avg_NEURON)
xlabel('Time (ms)')
ylabel('Potential (uV)')
title('Extracellular Potential from Averaged Single-Unit Recordings')

end