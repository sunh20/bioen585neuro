close all; clear all; clc;
load('neuron2.mat')
global data
data = avg_NEURON(26:175);

dt = 1e-5;  %time step
max_t = 0.01;  %max time
tspan = 0:dt:max_t;
maxSpike = 30;
rest = -65;

% binary firing inputs for each neuron:
neuronCount = 3;
%fire = randi([0 1], neuronCount, length(tspan));  % each neuron = 1 row
fire = zeros(neuronCount,length(tspan));
fire(1,100:105) = 1;
fire(1,400) = 1;
fire(1,700) = 1;

fire(2,105:110) = 1;
fire(2,500) = 1;
fire(2,800) = 1;
[r, c] = size(fire);

% summed extracellular potential:
ec = zeros(r, c);
sum = zeros(1, c);
for neuronInd = 1:r                 % for each neuron
    for i = 1:(c - length(data))    % for each time step
        if fire(neuronInd, i) == 1
            ec(neuronInd, i+1:i+length(data)) = ec(neuronInd, i+1:i+length(data))' + data;
            sum(i+1:i+length(data)) = sum(i+1:i+length(data))' + data;
        end
    end
    subplot(neuronCount, 1, neuronInd);
    plot(tspan,ec(neuronInd,:));  
    title(strcat("Neuron #", num2str(neuronInd)));
   
end

figure(2)
plot(tspan, sum);
title('Neuron Sum');

