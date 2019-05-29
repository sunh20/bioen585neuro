classdef neuron < handle
    properties
        inter;
        extra;
        resting;
        threshold;
        max;
        output;
        name;
    end
    methods
        function obj = neuron(inter, extra, resting, threshold, output, name)
            if nargin == 0
                obj.resting = -65;
                obj.inter = [obj.resting];
                obj.threshold = 70;
                obj.output = 70;
                obj.extra = [obj.resting];
            else
                obj.inter = inter;
                obj.extra = extra;
                obj.resting = resting;
                obj.threshold = threshold;
                obj.output = output;
                obj.name = name;
            end
        end
        
        function spike = addPotential(obj, stimulus)
            spike = 0;
            if obj.inter(end) >= obj.max
                obj.inter(end + 1) = obj.resting;
                spike = obj.output;
            elseif obj.inter(end) >= obj.threshold
                obj.inter(end + 1) = obj.inter(end) + ((obj.max - obj.threshold) / 2);
            else 
                obj.inter(end + 1) = obj.inter(end) + stimulus;
            end
        end
        
        function setPotential(obj, potential)
            obj.inter = potential;
        end
    end
end
