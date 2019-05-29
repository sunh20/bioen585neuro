close all; clc;
load('neuron2.mat')
global data 
data = avg_NEURON;
a =  4745;  % time scale of recovery u
b = 5;    % sensitivity of recovery
c = 16.7;    % mV, post spike reset for v
d = 2;      % post spike reset for u
e = -2631.7;
f = 3;
g = 6481.8;
% guess the parameters [r a b m] and initial conditions[hares lynx]:
guesses = [a, b, c, d, e, f, g];
% guesses = [a, b, c];
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
% tspan = 1e-5:1e-5:0.0020;
% y0 = [guesses(5) guesses(6)];
options=[];
% [t,y] = ode23s(@neuralODE,tspan,y0,options,guesses);
t = 1e-5:1e-5:0.002;
y = neuralODE(t,guesses);
plot(t,data,'o',t,y) ; drawnow 
% determine the weighted least-squares by comparing model to data:
J = sum(((data-y)).^2);
% note that the above function assumes a certain error model.
end

function y = neuralODE(t,p)
tspan = 1e-5:1e-5:0.0020;
y = zeros(length(tspan),1);
for idx = 1:length(tspan)-1
%     y(idx) = p(1)*(t(idx)^4) + p(2)*(t(idx)^3);
      y(idx) = p(3)*sinc(p(1)*t(idx)-p(2)) - p(4)*sin(p(5)*t(idx)) + p(6)*cos(p(7)*t(idx));
end
end
