close all; clear all; clc;
load('neuron2.mat')
global data
data = avg_NEURON(26:175);

dt = 1e-5;  %time step
max_t = 2;  %max time
tspan = 0:dt:max_t;
maxSpike = 30;
rest = -65;


% binary firing inputs for each neuron:
neuronCount = 3;
fire = randi([0 1], neuronCount, length(tspan));  % each neuron = 1 row
[r, c] = size(fire);

% summed extracellular potential:
ec = zeros(r, c);
sum = zeros(1, c);
for neuronInd = 1:r
    for i = 1:(c - length(data))
        if fire(neuronInd, i) == 1
            for j = 1:length(data)
                k = i + j - 1;
                ec(neuronInd, k) = ec(neuronInd, k) + data(j);
                sum(k) = sum(k) + data(j);
            end
        end
    end
    subplot(neuronCount, 1, neuronInd);
    plot(tspan,ec(neuronInd,:));  
    title(strcat("Neuron #", num2str(neuronInd)));
   
end

figure(2)
plot(tspan, sum);
title('Neuron Sum');

