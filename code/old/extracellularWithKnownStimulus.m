close all; clc;
load('neuron2.mat')
global data 
data = avg_NEURON(26:175);
max_t = 0.1;
dt = 1e-5;
tspan = 0:dt:max_t;
fire = zeros(2, length(tspan));
fire(1, 562) = 1;
fire(1, 7000) = 1;
fire(2, 563) = 1;
fire(2, 7000) = 1;
maxSpike = 30;
rest = -65;
extra = zeros(1,length(fire_1));
extra_ind = zeros(2, length(fire_1));
[m,n] = size(fire);
for go = 1:m
    for i = 1:(length(fire_1)-length(data))
        if fire(go, i) == 1
            for j = 1:length(data)
                k = i + j - 1;
                extra(k) = extra(k) + data(j);
                extra_ind(go,k) = extra_ind(go,k) + data(j);
            end 
        end
        end
%     if extra(i) >= maxSpike
%         extra(i) = maxSpike;
%         extra(i+1) = rest;
%     end
% end
end
plot(tspan,extra)
title('Summed Extracellular Potential')
xlabel('time (s)')
ylabel('extracellular potential (mV)')
figure()
subplot(2,1,1)
plot(tspan, extra_ind(1,:))
title('individual neurons extracellular potential')
legend('neuron 1')
subplot(2,1,2)
plot(tspan, extra_ind(2,:))
legend('neuron 2')
xlabel('time (s)')
ylabel('extracellular potential (mV)')