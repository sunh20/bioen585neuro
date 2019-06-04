function genFigures(t,network,adjMatrix,spiking,LFP,EC)

disp('Generating figures...')
networkSize = length(network);

figure(1)
hold on

% Plots each neuron's intracellular potential
labels = cell(networkSize,1);           % neuron labels
neuron_type = zeros(networkSize,1);     % 1-excite, 0-inhib
for i = 1:networkSize
    plot(t, network{i}.intra)
    labels{i} = "Neuron " + i;
    neuron_type(i) = ~network{i}.inhib;
end

legend(labels)

% Plots visual graph of network connections
figure(2)
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
figure(3)
h1 = heatmap(adjMatrix);

if sum(neuron_type==0) == 0     % there are only excitatory (white to red)
	colorMap = [ones(256,1),linspace(1,0,256)',linspace(1,0,256)'];
elseif sum(neuron_type==1) == 0 % there are only inhibitory (blue to white)
    colorMap = [linspace(0,1,256)',linspace(0,1,256)',ones(256,1)];
else                            % has both, blue to white to red
    colorMap = [[linspace(0,1,128),ones(1,128)]',[linspace(0,1,128),linspace(1,0,128)]',[ones(1,128),linspace(1,0,128)]'];
end

h1.Colormap = colorMap;
title('Network connectivity weights')
ylabel('From Neuron')
xlabel('To Neuron')

% plots spiking and LFP
figure(4)   % plots individual firing of all neurons
title('Individual neuron firing')

figure(5)   % plots individual extracellular potentials
title('Individual neuron extracellular potentials')

figure(6)   % plots overall LFP
title('LFP Summed behavior');

for neu = 1:networkSize
    firings = find(spiking(neu,:));
    
    figure(4)
    plot(firings,neu+zeros(length(firings),1),'.'); hold on
    xlim([0 length(t)])
    ylim([0 networkSize])
    
    figure(5)
    subplot(networkSize,1,neu)
    plot(t,EC(neu,:))
end

figure(6)
% LFP envelope - root mean squared
[up,~] = envelope(LFP,300,'rms');

plot(t, LFP);
hold on
plot(t,up-up(1));
legend('Raw sum','RMS Envelope')
xlabel('Time (ms)')
ylabel('Potential (mV)')

figure(4)   % firings
xlabel('time steps')
ylabel('Neuron')

figure(5)   % ecs
xlabel('time (ms)')
ylabel('Potential (mV)')

end