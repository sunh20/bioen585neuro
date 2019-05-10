# bioen585neuro

### BIOEN 485/585 Final	Project: Neuro group
###### Spring 2019
**Title**: Simulating stimulation-induced network plasticity in ‘rich clubs’ by measuring changes in local-field potentials from modeled single-unit simple neurons 

**Shorter title**: Modeling network plasticity from single-unit simple neurons

**Group members**:  
- Samantha Sun - 1st year PhD student (sunh20@uw.edu)
- Kelsey Luu - 3rd year undergraduate student (kelseytl@uw.edu)

**Consultants**:  
  Jonathan Mischler (jmishler@uw.edu) – 2nd year graduate student in Fetz lab  
  Larry Shupe (lshupe@uw.edt) – Senior Researcher in Fetz lab  

**Importance**: With advances in neural recording technologies, it is now possible to simultaneously perform single-site recordings and local field potential (LFP) recordings. However, there are still questions regarding the relationship between individual neuron spiking and the overall LFP shape and whether we can learn about the behavior of the network of neurons from the LFP it generates. 

Of particular interest to this proposal is whether we can model stimulation-induced plasticity between networks of single-unit neurons, which will allow us to predict how neural networks may change with different stimulation inputs and inform future stimulation methods to modulate network plasticity in the brain. 

**Previous knowledge**: There are many computational models of neurons that exist, most notably the Hodgkin-Huxley model that relates a neuron to an electrical circuit. Other models range from simple integrate-and-fire to complex neural network models. Each model has its benefits and drawbacks, and it’s important to consider what question is trying to be answered when deciding which model to use. Since this project involves scaling up to model a network of neurons, we decided on a simple neuron model developed by Izhikevich, which is an ODE model that is able to mimic the behavior of the 20 most fundamental electrical waveforms of neurons[1]. When considering how neural connections change with plasticity, the prominent theory is spike-timing dependent plasticity (STDP), which states that if one neuron fires just before another neuron repeatedly, then the strength of their connection increases. Research that explores how external stimulation changes plasticity has validated STDP, and our goal in this project is to computationally model stimulation to determine whether the network change matches STDP rules. 

**Questions to be addressed**: Can we modify the simple neuron model to accurately replicate physiological data? How do single neurons contribute to the overall network LFP? How does external stimulation change the behavior between two networks of neurons?

**Modeling approach**: The plan is to take the simple neuron model developed by Izhikevich to create two classes of neurons: tonic and bursting phasic. I chose these two because I have previously collected neural recording from a cockroach leg that exhibited behaviors that can be explained with these two neuron types. 

The *first aim* of this project would be to implement this simple neuron model and create a small group of neurons (not connected) that matches the behavior I recorded. This will allow us to find out the physiologically relevant parameters and time scales we should be using.

The *second aim* of the project is to scale up to a network-level so that we could measure a “local field potential (LFP)” or simply a signal that represents the summed activity of all the neurons in the network. LFPs are very commonly used to record neural activity and there are a lot of data that exists on what LFPs should look like. The main aspect in this aim is figure out how to connect the neurons and how many neurons to use. To determine how the network is connected, we will reference literature to see how the brain is typically connected. Previous research using network modeling has identified the brain having “small-world” properties, where there are densely connected groups or “rich clubs” of neurons that are sparsely connected to other densely connected groups[2]. We can optionally determine how much spontaneous firing (stochastic modeling) affects the overall network behavior. For this aim, we will ensure that our network is densely connected along with other network properties that we find in literature. We will validate this by comparing our modeled LFPs to experimentally recorded LFPs from literature. 

The *third aim* of this project (if there is time) would be to see how the network changes when introducing stimulation. For this, we will create two “rich clubs” of neurons and introduce a Dirac function that acts as external stimulation. We will explore what types of stimulation protocols to use, including common ones such as repetitive single-site stimulation and paired pulse stimulation. We will measure the LFPs and how they change before and after stimulation. We expect our model to follow STDP plasticity rules as explained in literature.

**References**:
1. 	Izhikevich EM. Simple model of spiking neurons. IEEE Trans Neural Networks. 2003;14(6):1569-1572. doi:10.1109/TNN.2003.820440

2. 	Bullmore E, Sporns O. Complex brain networks: Graph theoretical analysis of structural and functional systems. Nat Rev Neurosci. 2009;10(3):186-198. doi:10.1038/nrn2575

**Recommended reads**:  
1. https://www.izhikevich.org/publications/dsn.pdf  

   Book that has a really good description of the different neuron models and basic introduction to neurons if you need a refresher. Recommend reading pages 8-15, 20, 267-277 for model information and chapter 1 if you need a neuron refresher.   

2. https://www.annualreviews.org/doi/full/10.1146/annurev.neuro.31.060407.125639  
https://www.sciencedirect.com/science/article/pii/S0896627312007039?via%3Dihub  

   Papers that explains the different plasticity rules (STDP, Hebb rule, plasticity models). Only need to read the introduction for the first paper. For the second paper, take a look at Figure 2 and make sure you understand what that means. We will be referencing the Hebbian STDP model.  

3. https://www.researchgate.net/publication/317579637_Spiking_Neuron_Models_A_Review  

   Paper on different neuron models. Mostly for reference, don’t actually read it unless you’re really interested because it’s super dense and I won’t read it lol.
