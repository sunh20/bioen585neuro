function [network] = runSimulation(t,dt,network,networkSize,stim,adjMatrix)

% Input stimulation to neurons 
% Neuron outputs (update with each time step)
outputs = zeros(size(network, 1), size(network, 2));
spikes = zeros(size(network, 1), size(network, 2));

% Run Simulation
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


end