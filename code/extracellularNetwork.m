close all; clear all; clc;
load('neuron2.mat')
load('example_spiking.mat')
global data
data = avg_NEURON(26:175);

dt = 1e-5;  %time step
max_t = 0.1;  %max time for example spiking.mat
% max_t = 2;  %max time for neuron2.mat
tspan = 1e-5:dt:max_t;

% binary firing inputs for each neuron:
neuronCount = 5;
%fire = randi([0 1], neuronCount, length(tspan));  % each neuron = 1 row
fire = spiking;
[r, c] = size(fire);

% summed extracellular potential:
ec = zeros(r, c);
ec_sum = zeros(1, c);
for neuronInd = 1:r                 % for each neuron
    for i = 1:(c - length(data))    % for each time step
        if fire(neuronInd, i) == 1
            ec(neuronInd, i+1:i+length(data)) = ec(neuronInd, i+1:i+length(data))' + data;
            ec_sum(i+1:i+length(data)) = ec_sum(i+1:i+length(data))' + data;
        end
    end
    subplot(neuronCount, 1, neuronInd);
    plot(tspan,ec(neuronInd,:));  
    title(strcat("Neuron #", num2str(neuronInd)));
   
end

figure(2)
plot(tspan, ec_sum);
title('Neuron Sum');

