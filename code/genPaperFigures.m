function genPaperFigures()
% generates all figures for this project
% does not rely on parameters so can run by section

%% Figure 1: borrowed from Izhikevich 2003 paper

%% Figure 2: Simple IZ neuron with step input

dt = 0.01;
t = 0:dt:100; % time span (ms)
I = zeros(length(t),1);

% input
I(1000:end) = 40;    % +40 mV square pulse

simpleIZ(t,dt,I)

%% Figure 1A: Averaged extracellular potential neuron
load('neuron2.mat')

figure;
plot(t*1e3, avg_NEURON)
xlabel('Time (ms)')
ylabel('Potential (uV)')
title('Extracellular Potential from Averaged Single-Unit Recordings')

%% Figure 2A: EPSP + IPSP
t =  0:0.01:4;
EPSP = genPSP(t,1,2);
IPSP = genPSP(t,0,2);

figure; 
plot(t,EPSP,t,IPSP)
title('EPSP & IPSP')
xlabel('Time (ms)')
ylabel('Potential (mV)')
legend('EPSP', 'IPSP')

%% Figure 3: 2 neuron network

networkSize1 = 2;        % # neurons in network

% time
dt = 0.01;              % time step - don't change this (yet)
t = 0:dt:50;           % time span (ms)

% stimulation
stim = zeros(length(t), networkSize1);
stim(500:750,1) = 40;
stim(1500:1750,2) = 40;
stim(2500:3000,1) = 40;

% generate network
network1 = cell(1, networkSize1);
network1{1} = neuron(1, false);  
network1{2} = neuron(2, true); 

% manually make network matrix
adjMatrix = zeros(networkSize1,networkSize1);
adjMatrix(1,2) = 0.8;
adjMatrix(2,1) = 0.8;

% run sim
network1 = runSimulation(t,dt,network1,networkSize1,stim,adjMatrix);

% plot
figure;
% Plots each neuron's intracellular potential
labels = cell(networkSize1,1);           % neuron labels
neuron_type = zeros(networkSize1,1);     % 1-excite, 0-inhib
subplot(2,1,1)
for i = 1:networkSize1
    plot(t, network1{i}.intra)
    hold on
    labels{i} = "Neuron " + i;
    neuron_type(i) = ~network1{i}.inhib;
end
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Neuron Voltage Response')

legend(labels)

subplot(2,1,2)
plot(t,stim)
ylim([0 50])
xlabel('Time (ms)')
ylabel('Voltage (mV)')
title('Stimulation per Neuron')
legend(labels)

%% Figure 4: Network graph of 10 neuron network
clearvars
networkSize1 = 10;
networkSize2 = 5;

% generate network
network1 = cell(1, networkSize1);
for i = 1:networkSize1
    network1{i} = neuron(i, false);  
end

network2 = cell(1, networkSize2);
for i = 1:networkSize2
    network2{i} = neuron(i, false);  
end

adjMatrix1 = genNetwork(network1,networkSize1,20);
adjMatrix2 = genNetwork(network1,networkSize1,70);
adjMatrix3 = genNetwork(network2,networkSize2,20);
adjMatrix4 = genNetwork(network2,networkSize2,70);
adjMatrix = {adjMatrix1,adjMatrix2,adjMatrix3,adjMatrix4};
strT = ["10 neurons, 20% density","10 neurons, 70% density",...
        "5 neurons, 20% density","5 neurons, 70% density"];

figure;
for i = 1:4
    % Plots visual graph of network connections
    subplot(2,2,i)
    if i < 3
        networkSize = 10;
    else
        networkSize = 5;
    end
    G = digraph(adjMatrix{i});
    G_plot = plot(G,'Layout','circle');
    G_plot.EdgeColor = zeros(1,3);
    G_plot.NodeColor = zeros(networkSize,3);
    G_plot.LineWidth = abs(G.Edges.Weight*2);        % line weights
    title(strT(i))
    axis off
end

figure;
for i = 1:4
    subplot(2,2,i)
    h1 = heatmap(adjMatrix{i});

    colorMap = [ones(256,1),linspace(1,0,256)',linspace(1,0,256)'];
   
    h1.Colormap = colorMap;
    title('Network connectivity weights')
    ylabel('From Neuron')
    xlabel('To Neuron')
    title(strT(i))
end

%% Figure 5: LFP RMS envelope
clearvars

networkSize = 10;       % # neurons in network
networkDensity = 50;    % range 0-100
inhibFrac = 0;        % fraction of inhib neurons

% time
dt = 0.01;              % time step - don't change this (yet)
t = 0:dt:50;           % time span (ms)

% stimulation
stim = zeros(length(t), networkSize);
stim(1000:6000,1:2) = 40; 

[network, adjMatrix, spiking] = genNeuronNetwork(networkSize,networkDensity,inhibFrac,t,dt,stim);
[LFP, ~] = getLFP(spiking,t);

% LFP envelope - root mean squared
[up,~] = envelope(LFP,300,'rms');

figure;
plot(t, LFP);
hold on
plot(t,up-up(1),'LineWidth',5);
legend('Raw sum','RMS Envelope')
xlabel('Time (ms)')
ylabel('Potential (mV)')
title('Average network activity - "LFP"')



end 