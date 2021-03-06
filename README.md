﻿# bioen585neuro

### BIOEN 485/585 Final	Project: Neuro group
###### Spring 2019
**Title**: Interrogating dynamics of biological neural networks of modeled single-unit simple neurons 

**Group members**:  
- Samantha Sun - 1st year PhD student (sunh20@uw.edu)
- Kelsey Luu - 3rd year undergraduate student (kelseytl@uw.edu)
- Grace Jun - 3rd year undergraduate student (gracejun@uw.edu)
- Meriam Lahrichi - 3rd year undergraduate student (meriaml@uw.edu)
- Jackson Chin - 4th year undergraduate student (jch1n@uw.edu)

**Consultants**:  
- Jonathan Mischler – 2nd year graduate student in Fetz lab (jmishler@uw.edu)
- Larry Shupe – Senior Researcher in Fetz lab (lshupe@uw.edt) 
- Dr. Eberhard Fetz - UW Faculty

**Importance**: With advances in neural recording technologies, it is now possible to simultaneously perform single-site recordings and local field potential (LFP) recordings. However, there are still questions regarding the relationship between individual neuron spiking and the overall LFP shape and whether we can learn about the behavior of the network of neurons from the LFP it generates. 

**Previous knowledge**: There are many computational models of neurons that exist, most notably the Hodgkin-Huxley model that relates a neuron to an electrical circuit. Other models range from simple integrate-and-fire to complex neural network models. Each model has its benefits and drawbacks, and it’s important to consider what question is trying to be answered when deciding which model to use. Since this project involves scaling up to model a network of neurons, we decided on a simple neuron model developed by Izhikevich, which is an ODE model that is able to mimic the behavior of the 20 most fundamental electrical waveforms of neurons[1].

**Questions to be addressed**: Can we modify the simple neuron model to accurately replicate physiological data? How do single neurons contribute to the overall network LFP? How does external stimulation change the behavior between two networks of neurons?

**Modeling approach**: The plan is to take the simple neuron model developed by Izhikevich to create two classes of neurons: tonic and bursting phasic. I chose these two because I have previously collected neural recording from a cockroach leg that exhibited behaviors that can be explained with these two neuron types. 

The *first aim* of this project would be to implement this simple neuron model and determine both the intracellular and extracellular behavior. The intracellular potential is inherent to the individual neuron, while the extracellular potential contributes to the overall extracellular field, which is typically what is being recorded when making neural recordings. 

The *second aim* of this project is to model the connections between neurons. From biology, we know that neurons interact through a signal cascade that eventually results in a change of post-synaptic potential, either excitatory (EPSP) or inhibitory (IPSP). When one neuron fires, it sends an EPSP or IPSP to receiving neurons, which changes the intracellular membrane potential of these neurons and either increases or decreases the likelihood of firing. This behavior needs to be reflected and confirmed through our model. 

The *third aim* of this project is to scale up to a network-level so that we could measure a “local field potential (LFP)” or simply a signal that represents the summed activity of all the neurons in the network. LFPs are commonly used to record neural activity, but it is unclear how individual neurons contribute to this signal. We model a population or netowrk of neurons by creating a graph theory framework. Graph theory networks are comprised of nodes and edges, which are analogous to neuron cell bodies and axons, and the directionality and weight of the edges can also be set. Graph theory has been widely used to represent brain connectivity, and previous work has identified specific network properties in the human brain related to its structure and organization [2]. For example, the human brain exhibits “small-world” properties, which is a result of having densely connected smaller networks that are sparsely connected to other dense networks. These properties helped direct how we designed our neuronal networks, where we primarily focused on modeling these densely connected smaller networks. After creating the initial network, here we measured the overall network behavior, the modeled LFP, given an external stimulus input.  We explored how the LFP behavior changed when altering network or external properties, such as network size, network density, and stimulus input. Our model provided a bottom-up approach to learn how different properties may affect the network behavior, as represented by the LFP, and relate these findings back to its implications in the human brain

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

**Additional**

![expanding contributions](https://github.com/sunh20/bioen585neuro/blob/master/figures/expanding_brain_s.png)
![theChooChooBrain](https://github.com/sunh20/bioen585neuro/blob/master/figures/choochoo.png)
![team memeber names](https://github.com/sunh20/bioen585neuro/blob/master/figures/names.png)