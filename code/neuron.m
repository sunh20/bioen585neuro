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
        inhib;
        spiking;
    end
    
    methods
        function obj = neuron()
            obj.resting = -65;
            obj.intra = [obj.resting];
            obj.threshold = -40;
            obj.output = 40;
            obj.maxSpike = 30;
            obj.eqnParams = [0.04 5 140 0.02 0.2 obj.resting 8 30];
            obj.sens = [obj.eqnParams(7)];
            obj.inhib = false;
            obj.spiking = 0;
        end
        
        function spike = addPotential(obj, stimulus, dt)
            spike = 0;
            if obj.spiking > 0
                spike = obj.output;
                obj.spiking = obj.spiking + 1;
                if obj.spiking > 500
                    obj.spiking = 0;
                end
            end
            if obj.intra(end) >= obj.maxSpike && obj.spiking == 0
                obj.intra(end) = obj.maxSpike; % makes sure spikes don't exceed this
                obj.intra(end+1) = obj.resting;
                obj.sens(end+1) = obj.sens(end) + obj.eqnParams(8);
                obj.spiking = 1;
            else 
                obj.sens(end+1) = obj.sens(end) + dt * (obj.eqnParams(4)... 
                                  * (obj.eqnParams(5) * obj.intra(end)...
                                  - obj.sens(end)));
                obj.intra(end+1) = obj.intra(end) + dt * (obj.eqnParams(1)...
                                   * obj.intra(end)^2 + obj.eqnParams(2)...
                                   * obj.intra(end) + obj.eqnParams(3)...
                                   - obj.sens(end) + stimulus);
            end            
        end
        
        function setPotential(obj, potential)
            obj.intra = potential;
        end
        
    end
end
