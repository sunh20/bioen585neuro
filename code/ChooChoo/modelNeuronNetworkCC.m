%% MODELING NETWORK DYNAMICS FROM SINGLE UNIT SIMPLE NEURON
% Samantha Sun
% Kelsey Luu
% Grace Jun
% Meriam Lahrichi
% Jackson "Choo Choo" Chin
% BIOEN 485/585 final project
% June 2019
%
% This function builds a biological neuron network based on the parameters 
% specified in the function. Output provides information about the 
% network connectivity, individual neuron potentials (intra and
% extracellular), and overall network behavior (local-field potential)

clear all; close all; clc
%% specify parameters
addpath(genpath('C:\Users\Jackson\Documents\GitHub\bioen585neuro\code'))
addpath(genpath('\\studentfile.student.bioeng.washington.edu\usr$\jch1n\Documents\GitHub\bioen585neuro\code'))

networkSize = 50;       % # neurons in network
inhibFrac = 0;        % fraction of inhib neurons

% time
dt = 0.1;              % time step - don't change this (yet)
t = 0:dt:1000;           % time span (ms)

% stimulation
stim = zeros(length(t), networkSize);
stim(1:1000,1) = 40; 

netDensities = 0:10:100;
trials = 200;

spikes = zeros(length(netDensities), trials);
devSpikes = zeros(length(netDensities), trials);
meanSpikes = zeros(length(netDensities), trials);
zeroSpikes = zeros(length(netDensities), trials);
zeroOuts = zeros(length(netDensities), trials);
zeroIns = zeros(length(netDensities), trials);
isolatedNeurons = zeros(length(netDensities), trials);
spikeSpan = zeros(length(netDensities), trials);
LFPs = zeros(length(netDensities), length(t));
spikeLogs =  zeros(length(netDensities), length(t) - 1);

tic
for i = 1:1:length(netDensities)
    for j = 1:trials
        %% generate network
        [network, adjMatrix, spiking] = genNeuronNetwork(networkSize,netDensities(i),inhibFrac,t,dt,stim);

        %% get spiking info
        [LFP, EC] = getLFP(spiking,t);

        %% some (sanity) plots
        % genFigures(t,network,adjMatrix,spiking,LFP,EC);

        %% Some stats
        fprintf('Model run for %d to %d ms\n',t(1),t(end))
        fprintf('Total number of spikes: %d\n',sum(sum(spiking)))
        
        spikeRow = sum(spiking, 2);
        
        spikes(i, j) = sum(sum(spiking));
        devSpikes(i, j) = std(spikeRow);
        meanSpikes(i, j) = mean(spikeRow);
        zeroSpikes(i, j) = sum(spikeRow==0);
        zeroIns(i, j) = sum(sum(adjMatrix)==0);
        zeroOuts(i, j) = sum(sum(adjMatrix, 2)==0);
        isolatedNeurons(i, j) = checkIsolated(adjMatrix);
        spikeInd = find(sum(spiking));
        spikeSpan(i, j) = spikeInd(end);
    end
    LFPs(i,:) = LFP;
    spikeLogs(i, :) = sum(spiking);
end

solTime = toc
disp("Solution Time: " + solTime)
%% Average Activity Plot

figure(1)
hold on

plot(netDensities, mean(meanSpikes,2))
errorbar(netDensities, mean(meanSpikes, 2), mean(devSpikes, 2))
title("Average Neuron Activity vs. Network Density")
xlabel("Network Density (%)")
ylabel("Average Synapses per Neuron")


%% Isolated Neuron Plot

figure(2)
hold on

plot(netDensities, mean(isolatedNeurons, 2))
errorbar(netDensities, mean(isolatedNeurons, 2), std(isolatedNeurons, 0, 2))
title("Isolated Neurons vs. Network Density")
xlabel("Network Density (%)")
ylabel("Isolated Neurons in Network")

%% Synapse Elapses

figure(3)
hold on

plot(netDensities, mean(spikeSpan, 2) * dt)
errorbar(netDensities, mean(spikeSpan, 2) * dt, std(spikeSpan, 0, 2) * dt)
title("Span of Synapses vs. Network Density")
xlabel("Network Density (%)")
ylabel("Time Between First and Last Synapses (ms)")

save('FiftyNeuronRunLong');

%% Functions

function iso = checkIsolated(adjMatrix)
    iso = 0;
    
    for i = 1:size(adjMatrix)
        if sum(adjMatrix(:, i)) == 0 && sum(adjMatrix(i, :)) == 0
            iso = iso + 1;
        end
    end
end