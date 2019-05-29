classdef neuron < handle
    properties
        potential;
        resting;
        threshold;
        output;
        decay;
        name;
    end
    methods
        function obj = neuron(potential, threshold, output, decay)
            if nargin == 0
                obj.resting = -65;
                obj.potential = [obj.resting];
                obj.threshold = 70;
                obj.output = 20;
                obj.decay = 20;
            else
                obj.potential = potential;
                obj.threshold = threshold;
                obj.output = output;
                obj.decay = decay;
            end
        end
        
        function spike = addPotential(obj, stimulus)
            spike = 0;
            if obj.potential(end) >= obj.threshold
                obj.potential(end + 1) = obj.resting + stimulus;
            else 
                obj.potential(end + 1) = obj.potential(end) + stimulus;
            end
            if obj.potential(end) >= obj.threshold
                spike = obj.output;
            end
        end
        
        function setPotential(obj, potential)
            obj.potential = potential;
        end
        
        function setNext(obj, next)
            obj.next = next;
        end
        
        function decayPotential(obj)
            obj.potential = obj.potential - obj.decay;
        end
    end
end
