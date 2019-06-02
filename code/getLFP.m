function [LFP, ec] = getLFP(fire,max_t)
% receives input matrix where each row is a neuron's firing rate
% max_t is the time we want to run it for

load('neuron2.mat')
data = avg_NEURON(26:175); 

dt = 1e-5;      % time step - cannot change since it's same time step as data
tspan = 0:dt:max_t;

num_neuron = size(fire,1);

% summed extracellular potential:
ec = zeros(num_neuron, length(tspan));
LFP = zeros(1, length(tspan));
for neuronInd = 1:num_neuron                    % for each neuron
    for i = 1:(length(tspan) - length(data))    % for each time step
        if fire(neuronInd, i) == 1
            ec(neuronInd, i+1:i+length(data)) = ec(neuronInd, i+1:i+length(data))' + data;
            LFP(i+1:i+length(data)) = LFP(i+1:i+length(data))' + data;
        end
    end 
end

end