clear all; close all;

%% Setup

resting = -65;
network = cell(1, 10);

for i = 1:size(network, 2)
    network{i} = neuron;
    network{i}.name = i;
end

adjMatrix = zeros(10, 10);

adjMatrix(1, 2) = 1;
adjMatrix(1, 3) = 0.5;
adjMatrix(1, 4) = 0.25;
adjMatrix(2, 5) = 1;

%% Input

stim = zeros(1, 10);
stim(1) = 20;

outputs = zeros(1, 10);
spikes = zeros(1, 10);

for i = 1:100
    for j = 1:size(network, 2)
        spikes(j) = network{j}.addPotential(stim(j) + outputs(j));
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
    plot(0:100, network{i}.potential)
end

labels = {};
for i = 1:size(network, 2)
    labels{i} = "Neuron " + i;
end
legend(labels)