close all; clc;
load('neuron2.mat'); 
global data 
data = avg_NEURON;
global t 
t = 1e-5:1e-5:0.002;

p1 = 6.5512e+30
p2 = -7.7659e+28
p3 = 4.0037e+26
p4 = -1.1754e+24
p5 = 2.1598e+21
p6 = -2.5684e+18
p7 = 1.9707e+15
p8 = -9.3824e+11
p9 = 2.5104e+08
p10 = -28739


% guess the parameters 
guesses = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10];
% optimize the parameters and initial conditions:
[estimates, J] = fminsearch(@obj, guesses);
disp(estimates);
y = neuralODE(t,guesses);
plot(t(50:200), abs(data(50:200)-y(50:200)));


function J = obj(guesses)
global data
global t
y = neuralODE(t,guesses);
plot(t(50:200), data(50:200),'o', t(50:200), y(50:200), 'linewidth', 1.5); drawnow 
% determine the weighted least-squares by comparing model to data:
J = sum(((data-y)).^2);
figure(2)
% note that the above function assumes a certain error model.
end

function y = neuralODE(t,p)
tspan = 1e-5:1e-5:0.002;
y = zeros(length(tspan),1);
for i = 1:length(tspan)-1
    %sinc(8000t - 10) + tsin(10000t)
    % y(i) = p(1)*sinc(p(2)*t(i) + p(3)) + p(4)*t(i)*sin(p(5)*t(i) + p(6));
     y(i) = p(1)*t(i)^9 - p(2)*t(i)^8 + p(3)*t(i)^7 - p(4)*t(i)^6 + p(5)*t(i)^5 - p(6)*t(i)^4 + ...
      p(7)*t(i)^3 - p(8)*t(i)^2 + p(9)*t(i) - p(10);
end
end



