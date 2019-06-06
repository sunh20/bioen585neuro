function [network, adjMatrix, spiking] = genNeuronNetwork_validate(networkSize,networkDensity,inhibFrac,t,dt,stim,first_run)

%% Setup

% make network
if first_run
    network = cell(1, networkSize); % Neuron array

    for i = 1:size(network, 2)
        network{i} = neuron(i, false);  % create all excitatory network  
    end

    inhibCount = 0;
    while inhibCount < (networkSize * inhibFrac)
        for i = randi(networkSize, 1, 1)    % randomly select neuron 
            if network{i}.inhib == false    % if neuron is excitatory
                if network{i}.name ~= 1     % ensure neuron 1 isn't inhib
                    network{i} = neuron(i, true);   % make neuron inhibitory
                    inhibCount = inhibCount + 1;
                end
            end
        end
    end
    
    adjMatrix = genNetwork(network, networkSize, networkDensity);

else
    % load previous network
    load('adj_sim.mat')
    
    % clear previous network data
    for i = 1:networkSize
        network{i} = neuron(i, network{i}.inhib);   % copy only inhib data
    end
    
    % slightly randomize adj matrix weights
    adjMatrix(adjMatrix ~=0) = adjMatrix(adjMatrix ~=0) + (rand(1)-0.5)*0.5;
    
end

%% Input

% Input stimulation to neurons 
% Neuron outputs (update with each time step)
outputs = zeros(size(network, 1), size(network, 2));
spikes = zeros(size(network, 1), size(network, 2));

%% Run Simulation
disp('Running model simulation...')
for i = 1:length(t) - 1
    % Adds stimulation and output from previous step to network
    for j = 1:networkSize
        spikes(j) = network{j}.addPotential(stim(i, j) + outputs(j), dt);
    end
    
    % Resets outputs
    outputs = outputs * 0;
    
    % Collects outputs from previous time step
    for m = 1:size(spikes, 2)
        for n = 1:size(adjMatrix, 1)
            outputs(n) = outputs(n) + spikes(m) * abs(adjMatrix(m, n));
        end
    end
end

%% Get spiking activity - format for use later

spiking = zeros(networkSize,length(t)-1);
for i = 1:networkSize
    spiking(i,:) = network{i}.spikeLog;    
end

end