function [network, adjMatrix, spiking] = genNeuronNetwork(networkSize,networkDensity,inhibFrac,t,dt,stim)

%% Setup

network = cell(1, networkSize); % Neuron array

% network generation method #1 (Jackson):

% for i = 1:size(network, 2)
%     if mod(i,ceil(1/inhibFrac)) == 0
%         network{i} = neuron(i,true);  % neuron is inhib
%     else
%         network{i} = neuron(i,false);
%     end
% end



% network generation method #2 (Kelsey):

for i = 1:size(network, 2)
    network{i} = neuron(i, false);  % create all excitatory network  
end


inhibCount = 0;
while inhibCount < (networkSize * inhibFrac)
    for i = randi(networkSize, 1, 1)    % randomly select neuron 
        if network{i}.inhib == false    % if neuron is excitatory
            network{i} = neuron(i, true);   % make neuron inhibitory
            inhibCount = inhibCount + 1;
        end
    end
end

% make network
adjMatrix = genNetwork(network, networkSize, networkDensity);

%% Run Simulation
network = runSimulation(t,dt,network,networkSize,stim,adjMatrix);

%% Get spiking activity - format for use later

spiking = zeros(networkSize,length(t)-1);
for i = 1:networkSize
    spiking(i,:) = network{i}.spikeLog;    
end

end