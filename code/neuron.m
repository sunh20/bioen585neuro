classdef neuron < handle
    properties
        intra;
        resting;
        threshold;
        maxSpike;
        output;
        name;
        eqnParams;
        sens;
    end
    methods
        function obj = neuron()
            obj.resting = -65;
            obj.intra = [obj.resting];
            obj.threshold = -40;
            obj.output = 30;
            obj.maxSpike = 30;
            obj.eqnParams = [0.04 5 140 0.02 0.2 obj.resting 8 30];
            obj.sens = [obj.eqnParams(7)];
        end
        
        function spike = addPotential(obj, stimulus)
            spike = 0;
            if obj.intra(end) >= obj.maxSpike
                obj.intra(end) = maxSpike; % makes sure spikes don't exceed this
                obj.intra(end+1) = obj.resting;
                obj.sens(end+1) = obj.sens() + obj.eqnParams(8);
            else 
                obj.sens(end+1) = obj.sens(end) + dt * obj.eqnParams(4)... 
                                  * (obj.eqnParams(5) * obj.intra(end)...
                                  - obj.sens(end));
                obj.intra(end+1) = obj.intra(end) + dt * (obj.eqnParams(1) * obj.intra(idx)^2 + obj.eqnParams*v(idx) + C - u(idx) + I(idx));
            end
        
            % model coefficients
            % from paper: 0.04*v^2 + 5*v + 140
            % can change this to the format in the book
            A = 0.04;
            B = 5;
            C = 140;

            % parameters
            a = 0.02;   % time scale of recovery u
            b = 0.2;    % sensitivity of recovery
            c = -65;    % mV, post spike reset for v
            d = 8;      % post spike reset for u
            maxSpike = 30; % max spike potential

            % time
            dt = 0.01;
            t = 0:dt:100; % time span (units?)

            % variables
            u = zeros(length(t),1);
            v = zeros(length(t),1);
            u(1) = d;   % ICs
            v(1) = c;   % ICs

            if v(idx) >= maxSpike
                fprintf('Max spike reached at t=%.2f\n',idx*dt)
                v(idx) = maxSpike; % makes sure spikes don't exceed this
                v(idx+1) = c;
                u(idx+1) = u(idx) + d;
            else      
                % ODE: next = current + dt * dy/dt
                u(idx+1) = u(idx) + dt * (a * (b*v(idx) - u(idx)));
                v(idx+1) = v(idx) + dt * (A*v(idx)^2 + B*v(idx) + C - u(idx) + I(idx));
            end
            
        end
        
        function setPotential(obj, potential)
            obj.intra = potential;
        end
    end
end
