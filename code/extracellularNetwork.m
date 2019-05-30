close all; clc;
load('neuron2.mat')
global data 
data = avg_NEURON(26:175);
max_t = 2;
tspan = 0:dt:max_t;
fire_1 = randi([0 1],size(tspan));
fire_2 = zeros(1,length(tspan));
dt = 1e-5;
maxSpike = 30;
rest = -65;
extra = zeros(1,length(fire_1));
for i = 1:(length(fire)-length(data))
    if fire(i) == 1
        for j = 1:length(data)
            k = i + j - 1;
            extra(k) = extra(k) + data(j);
        end 

        if extra(i) >= maxSpike
            fire_2(i) = 1;
            for j = 1:length(data)
                k = i + j - 1;
                extra(k) = extra(k) + data(j);
            end 
        end
    end
%     if extra(i) >= maxSpike
%         extra(i) = maxSpike;
%         extra(i+1) = rest;
%     end
end

plot(tspan,extra)