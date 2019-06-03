function [LFP, EC] = genLFP(fire,tspan)
% receives input matrix where each row is a neuron's firing rate
% tspan is the time we want to run it for
% neuron2.mat has time steps in ms

load('neuron2.mat')
data = avg_NEURON(26:175); 

num_neuron = size(fire,1);

% summed extracellular potential:
EC = zeros(num_neuron, length(tspan));
LFP = zeros(1, length(tspan));
for neuronInd = 1:num_neuron                    % for each neuron
    for i = 1:(length(tspan) - length(data))    % for each time step
        if fire(neuronInd, i) == 1
            EC(neuronInd, i+1:i+length(data)) = EC(neuronInd, i+1:i+length(data))' + data;
            LFP(i+1:i+length(data)) = LFP(i+1:i+length(data))' + data;
        end
    end 
end

end