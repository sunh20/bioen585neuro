%% MODELING NETWORK DYNAMICS FROM SINGLE UNIT SIMPLE NEURON
% Samantha Sun
% Kelsey Luu
% Grace Jun
% Meriam Lahrichi
% Jackson theChooChooChin
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
inhibFrac = 0.5;        % fraction of inhib neurons

% time
dt = 0.01;              % time step - don't change this (yet)
t = 0:dt:100;           % time span (ms)

% stimulation
stim = zeros(length(t), networkSize);
stim(:, 1) = 20; 

%% generate network
[network, adjMatrix, spiking] = genNeuronNetwork(networkSize,networkDensity,inhibFrac,t,dt,stim);

%% get spiking info


%% some (sanity) plots
figure;
hold on

% Plots each neuron's intracellular potential log
labels = cell(networkSize,1);           % neuron labels
neuron_type = zeros(networkSize,1);     % 1-excite, 0-inhib
for i = 1:networkSize
    plot(t, network{i}.intra)
    labels{i} = "Neuron " + i;
    neuron_type(i) = ~network{i}.inhib;
end

legend(labels)

% Plots visual graph of network connections
figure;
G = digraph(adjMatrix);
G_plot = plot(G,'Layout','circle');
G_plot.EdgeColor = zeros(1,3);
G_plot.NodeColor = zeros(networkSize,3);
G_plot.NodeColor(neuron_type==0,:) = repmat([0,0,1],...
                [sum(neuron_type==0) 1]);   % label inhib neurons as blue
G_plot.NodeColor(neuron_type==1,:) = repmat([1,0,0],...
                [sum(neuron_type==1) 1]);   % label excite neurons as red
G_plot.LineWidth = abs(G.Edges.Weight*5);        % line weights
title('Network visual graph')
axis off

% plot heatmap showing connections
figure;
h1 = heatmap(adjMatrix);
h1.Colormap = jet;
title('Network connectivity weights')
ylabel('From Neuron')
xlabel('To Neuron')
