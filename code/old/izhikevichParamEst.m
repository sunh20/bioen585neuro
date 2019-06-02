% Performs parameter estimation of an averaged single-unit neuron recording
% based on the Izhikevich neuron model. Used weighted least-squares error
% model and fminsearch.

close all; clc;
 load ('neuron2.mat')
global data 
data = avg_NEURON;
a = 0.02;   % time scale of recovery u
b = 0.2;    % sensitivity of recovery
c = -65;    % mV, post spike reset for v
d = 8;      % post spike reset for u
v0 = c;
u0 = d;
maxSpike = 30; % max spike potential

% model coefficients
% from paper: 0.04*v^2 + 5*v + 140
A = 0.04;
B = 5;
C = 140;
% guess the parameters [r a b m] and initial conditions[hares lynx]:
guesses = [a, b, c, d, v0, u0];
% optimize the parameters and initial conditions:
[estimates, J] = fminsearch(@obj,guesses);
disp(estimates);
% graph the model behavior using these optimized values:
% tspan = 1e-5:1e-5:0.0020;
% y0 = [estimates(5) estimates(6)];
% options=[];
% [t,y] = ode23s(@neuralODE,tspan,y0,options,estimates);
% plot(t,data,t,y(:,1),'o')

function J = obj(guesses)
global data
% determine the model behavior with the guesses values:
tspan = 1e-5:1e-5:0.0020;
y0 = [guesses(5) guesses(6)];
options=[];
[t,y] = ode23s(@neuralODE,tspan,y0,options,guesses);
plot(t,data,'o',t,y(:,1)) ; drawnow 
% determine the weighted least-squares by comparing model to data:
J = sum(((data-y(:,1))).^2);
% note that the above function assumes a certain error model.
end

function dydt = neuralODE(t,y,p)
tspan = 1e-5:1e-5:0.0020;
I = zeros(length(tspan),1);
I(65:120) = 40;  % +40 mV square pulse
A = 0.04;
B = 5;
C = 140;
maxSpike = 30;
y = zeros(length(tspan),2);
dydt = zeros(1, 2);
for idx = 1:length(tspan)-1
%     if reaches max spike potential
    if y(idx,1) >= maxSpike
       y(idx,1) = maxSpike; % makes sure spikes don't exceed this
       dydt = [(p(3) - maxSpike)/ 1e-5; p(4)];
    else      
%         ODE: next = current + dt * dy/dt
       dydt = [(A*y(idx,1)^2 + B*y(idx,1) + C - y(idx,2) + I(idx));
                (p(1) * (p(2)*y(idx,1) - y(idx,2)))];
    end
end


end