% testing network LFP - just run this
% clear all; close all; clc

% % will get the fire matrix from NeuronNetwork code
% % for now just hardcode to test
% dt = 0.01;  %time step
% max_t = 10;  %max time
% tspan = 0:dt:max_t;
% numNeurons = 5;
% %fire = randi([0 1], numNeurons, length(tspan));
% fire = zeros(numNeurons, length(tspan));
% fire(1,1:10) = 1;
% fire(2,30) = 1;
% fire(3,50:55) = 1;
% fire(4,100) = 1;
% fire(5,500:700) = 1;

% using generated data from modelNeuronNetwork
fire = spiking;
tspan = t;
numNeurons = networkSize;

% call function
[LFP, ec] = genLFP(fire,tspan);

% plot everything
figure(1)   % firings
xlabel('time steps')

figure(2)   % ecs
xlabel('time (ms)')

figure(3)   % LFP
xlabel('Time (ms)')

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
    xlabel('Time (ms)')
end

figure(3)
plot(tspan, LFP);
title('Neuron Sum');