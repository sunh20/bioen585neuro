clear all; close all;

%% Setup

resting = -65;
network = cell(1, 2);

for i = 1:size(network, 2)
    network{i} = neuron;
    network{i}.name = i;
end

% future adj matrix function (genNetwork) will go here
adjMatrix = zeros(size(network, 1), size(network, 2));

adjMatrix(1, 2) = 1;
adjMatrix(2, 1) = 0.5;

%% Input

stim = zeros(size(network, 1), size(network, 2));
stim(1) = 20;

outputs = zeros(size(network, 1), size(network, 2));
spikes = zeros(size(network, 1), size(network, 2));

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

for i = 1:length(t) - 1
    for j = 1:size(network, 2)
        spikes(j) = network{j}.addPotential(stim(j) + outputs(j), dt);
    end
    
    outputs = outputs * 0;
    
    for m = 1:size(spikes, 2)
        for n = 1:size(adjMatrix, 1)
            outputs(n) = outputs(n) + spikes(m) * adjMatrix(m, n);
        end
    end
end

%% Sanity Plots

hold on

for i = 1:size(network, 2)
    plot(t, network{i}.intra)
end

labels = {};
for i = 1:size(network, 2)
    labels{i} = "Neuron " + i;
end

legend(labels)

plot(t, I)