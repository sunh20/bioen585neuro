classdef neuron < handle
    properties
        resting; % Resting membrane potential
        intra; % Log of intracellular potentials
        output; % Output voltage from synapse
        maxSpike; % Maximum voltage of synapse spike
        eqnParams; % Izhikevich model
        sens; % Log of sensitivity values
        inhib; % Marks if neuron is inhibitory
        spiking; % Marks current time in spike
        name; % Name of neuron
        spikeLog; % Tracks when spikes occur
    end
    
    methods
        function obj = neuron()
            obj.resting = -65;
            obj.intra = [obj.resting]; 
            obj.maxSpike = 30; 
            obj.eqnParams = [0.04 5 140 0.02 0.2 obj.resting 8 30];
            obj.sens = [obj.eqnParams(7)];
            obj.inhib = false; 
            obj.spiking = 0; 
            obj.spikeLog = [];
            
            % 4 ms PSP, same dt as NeuronNetwork
            if obj.inhib
                fprintf('Neuron %d is inhibitory\n',obj.name)
                obj.output = genPSP(0.01:0.01:4,0,2); 
            else
                obj.output = genPSP(0.01:0.01:4,1,2); 
            end
            
        end
        
        function spike = addPotential(obj, stimulus, dt)
            % Adds the provided stimulus to the neuron's potential. Note
            % that dt corresponds to the time between steps. 
            % If the neuron synapses (i.e. threshold is exceeded), causes
            % neuron to output a post synaptic potential.
            
            spike = 0; % Output of neuron. Modify this for output of neuron
            
            % Runs if neuron is currently spiking. Outputs post synaptic
            % potential if neuron is spiking - duration is length of the
            % PSP/output array
            if obj.spiking > 0
                spike = obj.output(obj.spiking);%(obj.spiking);
                obj.spiking = obj.spiking + 1;
                if obj.spiking > length(obj.output)
                    obj.spiking = 0;
                end
            end
            
            % Runs Izhikevich. Adds current intracellular potential to
            % neuron log. If neuron exceeds maxSpike, begins spiking and
            % signals start of post synaptic potential.
            if obj.intra(end) >= obj.maxSpike && obj.spiking == 0
                obj.intra(end) = obj.maxSpike; % makes sure spikes don't exceed this
                obj.intra(end+1) = obj.resting;
                obj.sens(end+1) = obj.sens(end) + obj.eqnParams(8);
                obj.spiking = 1;
                obj.spikeLog(end + 1) = 1;
            else 
                obj.sens(end+1) = obj.sens(end) + dt * (obj.eqnParams(4)... 
                                  * (obj.eqnParams(5) * obj.intra(end)...
                                  - obj.sens(end)));
                obj.intra(end+1) = obj.intra(end) + dt * (obj.eqnParams(1)...
                                   * obj.intra(end)^2 + obj.eqnParams(2)...
                                   * obj.intra(end) + obj.eqnParams(3)...
                                   - obj.sens(end) + stimulus);
               obj.spikeLog(end + 1) = 0;
            end            
        end
        
        function setPotential(obj, potential)
            % Sets the potential of the neuron to the provided value.
            obj.intra = potential;
        end
        
    end
end
