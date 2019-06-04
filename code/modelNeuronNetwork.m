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
networkSize = 10;       % # neurons in network
networkDensity = 70;    % range 0-100
inhibFrac = 0;        % fraction of inhib neurons

% time
dt = 0.01;              % time step - don't change this (yet)
t = 0:dt:100;           % time span (ms)

% stimulation
stim = zeros(length(t), networkSize);
stim(5000:end,1) = 40; 

%% generate network
tic
[network, adjMatrix, spiking] = genNeuronNetwork(networkSize,networkDensity,inhibFrac,t,dt,stim);
fprintf('Model run time: %.2f seconds\n',toc)

%% get spiking info
[LFP, EC] = getLFP(spiking,t);

%% Some stats
fprintf('Model run for %d to %d ms\n',t(1),t(end))
fprintf('Total number of spikes: %d\n',sum(sum(spiking)))

%% some (sanity) plots
genFigures(t,network,adjMatrix,spiking,LFP,EC);