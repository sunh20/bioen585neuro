clear all; close all;
%% Initial Inputs

networkSize = 5; % Number of neurons
inhibFrac = 1; % Fraction of neurons to be set as inhibitory

%% Setup

network = cell(1, networkSize); % Neuron array

for i = 1:size(network, 2)
    if rand(1) < inhibFrac
        network{i} = neuron(false);
    else
        network{i} = neuron(true);
    end
    network{i}.name = i;
end

% make network
adjMatrix = genNetwork(networkSize, 70);

%% Input

% Input stimulation to neurons 
% Neuron outputs (update with each time step)
outputs = zeros(size(network, 1), size(network, 2));
spikes = zeros(size(network, 1), size(network, 2));

% time
dt = 0.01;
t = 0:dt:100; % time span (units?)

% Input stimulation to neurons 
stim = zeros(size(t, 2), size(network, 2));
stim(:, 1) = 20; 

%% Run Simulation

for i = 1:length(t) - 1
    % Adds stimulation and output from previous step to network
    for j = 1:size(network, 2)
        spikes(j) = network{j}.addPotential(stim(i, j) + outputs(j), dt);
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

figure
hold on

% Plots each neuron's intracellular potential log
for i = 1:size(network, 2)
    plot(t, network{i}.intra)
end

labels = cell(networkSize,1);
spikeLogs = [];
for i = 1:size(network, 2)
    labels{i} = "Neuron " + i;
end

legend(labels)

%% format spikes

spiking = zeros(networkSize,length(t)-1);
for i = 1:networkSize
    spiking(i,:) = network{i}.spikeLog;    
end


