% testing network LFP - just run this
clear all; close all; clc

% will get the fire matrix from NeuronNetwork code
% for now just hardcode to test
dt = 1e-5;  %time step
max_t = 0.01;  %max time
tspan = 0:dt:max_t;
numNeurons = 10;
fire = randi([0 1], numNeurons, length(tspan));

% call function
[LFP, ec] = genLFP(fire,tspan);

% plot everything
figure(1)   % firings
figure(2)   % ecs
figure(3)   % LFP
for neu = 1:numNeurons
    firings = find(fire(neu,:));
    figure(1)
    plot(firings,neu+zeros(length(firings),1),'.'); hold on
    xlabel('time span')
    xlim([0 length(tspan)])
    ylim([0 numNeurons])
    
    figure(2)
    subplot(numNeurons,1,neu)
    plot(tspan,ec(neu,:))
    xlabel('Time (s)')
end

figure(3)
plot(tspan, LFP);
title('Neuron Sum');