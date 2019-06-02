clear all; close all;
%% Initial Inputs

networkSize = 5; % Number of neurons
inhibFrac = .3; % Fraction of neurons to be set as inhibitory

%% Setup

network = cell(1, networkSize); % Neuron array

for i = 1:size(network, 2)
    network{i} = neuron;
    network{i}.name = i;
end

% future adj matrix function (genNetwork) will go here
adjMatrix = genNetwork(networkSize, 70);

%% Input

% Input stimulation to neurons
stim = zeros(size(network, 1), size(network, 2));
stim(1) = 20;

% Nueron outputs (update with each time step)
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
    % Adds stimulation and output from previous step to network
    for j = 1:size(network, 2)
        spikes(j) = network{j}.addPotential(stim(j) + outputs(j), dt);
    end
    
    % Resets outputs
    outputs = outputs * 0;
    
    % Collects outputs from previous time step
    for m = 1:size(spikes, 2)
        for n = 1:size(adjMatrix, 1)
            outputs(n) = outputs(n) + spikes(m) * adjMatrix(m, n);
        end
    end
end

%% Sanity Plots

figure()

hold on

% Plots each neuron's intracellular potential log
for i = 1:size(network, 2)
    plot(t, network{i}.intra)
end

labels = {};
spikeLogs = [];
for i = 1:size(network, 2)
    labels{i} = "Neuron " + i;
end

legend(labels)