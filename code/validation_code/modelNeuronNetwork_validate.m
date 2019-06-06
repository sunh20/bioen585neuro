%% Validation of MODELING NETWORK DYNAMICS FROM SINGLE UNIT SIMPLE NEURON
%
% This function builds a biological neuron network based on the parameters 
% specified in the function. Output provides information about the 
% network connectivity, individual neuron potentials (intra and
% extracellular), and overall network behavior (local-field potential)

clear all; close all; clc

%% Running for the first time? Run simulation one time!
% For this code to work properly, we need to generate an initial simulated
% network and save it as a variable so that the same network is stimulated
% every time. The following variable, first_run, will facilitate this
% process and run the simulation experiment and save it as simulation.mat
% so that the simulation does not need to be run every time

first_run = true;
stimTimes = 100;    % run simulation 100 times (same network)
runTimes = 100;     % run model 100 times (different networks)

%% specify parameters
networkSize = 28;       % # neurons in network
networkDensity = 75;    % range 0-100
inhibFrac = 0.5;        % fraction of inhib neurons

% time
dt = 0.01;              % time step - don't change this (yet)
t = 0:dt:30;           % time span (ms)

% stimulation
stim_t = 10; % 10 ms of stim
stim = zeros(length(t), networkSize);
stim(1:stim_t/dt,1) = 40; 

%% simulated network - run stim 100 times
if first_run
    LFP_env_sim = zeros(length(t),stimTimes);
    LFP_ptp_sim = zeros(1,stimTimes);
    avg_spiking_sim = zeros(1,stimTimes);

    for i = 1:stimTimes
        tic

        [network, adjMatrix, spiking] = genNeuronNetwork_validate(networkSize,networkDensity,inhibFrac,t,dt,stim,first_run);

        % get spiking info
        [LFP, EC] = getLFP(spiking,t);
        fprintf('Running simulated network: %d/%d ,run time: %.2f seconds\n',i,stimTimes,toc)

        % get necessary things
        [up,~] = envelope(LFP,300,'rms');
        LFP_ptp_sim(i) = max(up-up(1));
        LFP_env_sim(:,i) = up-up(1);

        avg_spiking_sim(i) = mean(sum(spiking,2));

        if first_run
            save('adj_sim.mat','network')
            first_run = false;
        end
    end
    save('simulation.mat','LFP_env_sim','LFP_ptp_sim','avg_spiking_sim','stim','t')
end

%% generate 100 networks + get stats
% parameters to change (if needed)
% networkSize = 20;
% networkDensity = 50;

LFP_env = zeros(length(t),runTimes);
LFP_ptp = zeros(1,runTimes);
avg_spiking = zeros(1,runTimes);

for i = 1:runTimes
    
    % model network
    tic
    [network, adjMatrix, spiking] = genNeuronNetwork(networkSize,networkDensity,inhibFrac,t,dt,stim);
    
    % get spiking info
    [LFP, EC] = getLFP(spiking,t);
    fprintf('Model run: %d/%d, %.2f seconds\n',i,runTimes,toc)
    
    % get what you need
    [up,~] = envelope(LFP,300,'rms');
    LFP_ptp(i) = max(up-up(1));
    LFP_env(:,i) = up-up(1);
    
    avg_spiking(i) = mean(sum(spiking,2));
end
save('model.mat','LFP_env','LFP_ptp','avg_spiking','t')
%save('model_dens50.mat','LFP_env','LFP_ptp','avg_spiking','t')

%% Plots for comparison
clearvars
load('simulation.mat')
load('model.mat')

figure;
[l,p] = boundedline(t,mean(LFP_env_sim,2),std(LFP_env_sim'),'r--',t,mean(LFP_env,2),std(LFP_env'),'b--','transparency', 0.1);
outlinebounds(l,p);
xlabel('Time (ms)')
ylabel('Electric potential (mV)')
title('LFP - mean and standard deviation') 
legend('Simulated data','Modeled data')

figure;
AS = [mean(avg_spiking_sim),mean(avg_spiking)];
bar(AS)
xticklabels(["simulation","model"])
ylabel('Average neuron spiking')
hold on
errorbar(AS,[std(avg_spiking_sim),std(avg_spiking)],'k.')
title('Average neuron spiking comparison')

figure;
LP = [mean(LFP_ptp_sim),mean(LFP_ptp)];
bar(LP)
xticklabels(["simulation","model"])
ylabel('Electric potential (mV)')
hold on
errorbar(LP,[std(LFP_ptp_sim),std(LFP_ptp)],'k.')
title('LFP peak amplitude comparison')
