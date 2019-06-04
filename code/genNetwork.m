%% Generate biological neural networks
% This code generates a network of neurons based on known graph theory
% principles of neuron populations. We can modify parameters such as
% network size, density...(keep working on this)

function adj = genNetwork(network,size,density)
% size = number of neurons in network
% density = determines number of connections as a percent of 
% total possible connections (5 = 5% total network is connected)
adj = zeros(size,size);

% % random case
% adj = rand(size,size);
% adj = adj - diag(diag(adj));

% ID excitatory and inhibitory neurons
neuron_type = zeros(size,1);    % 1-excite, 0-inhib
for i = 1:length(network)
    neuron_type(i) = ~network{i}.inhib;
end

% add density information - determine number of connections and then
% randomly generate indices to fill in with randomly generates weights
% Need to make sure indices are not on the diagonal
num_connections = ceil(size*(size-1)*density/100); 
I = eye(size);          % use identity matrix to
diagonals = find(I);    % find indices of diagonals
adj_flat = reshape(adj,1,size*size); % flatten for easier indexing
idx = zeros(num_connections,1); % keep track of repeats

% for each connection
for i = 1:num_connections
    % get random index/connection
    rand_index = ceil(rand(1)*length(adj_flat));
    
    % ensure that index is not a diag and also has not been selected before
    while ismember(rand_index,diagonals) || ismember(rand_index,idx)
        rand_index = ceil(rand(1)*length(adj_flat));
    end
    idx(i) = rand_index;
    
    % assign random value [0.5,1]
    adj_flat(rand_index) = 0.5 + 0.5.*rand(1);
    
end

% unflatten matrix
adj = reshape(adj_flat,size,size);

% make inhib connections negative
adj(neuron_type == 0,:) = -adj(neuron_type == 0,:);

% info (sanity check)
fprintf('Generating a network of %d neurons and %d percent density\n',size,density)
fprintf('Expected number of connections: %d\n', num_connections)
fprintf('Number of connections: %d\n', length(find(adj)))
fprintf('Excitatory neurons: %d, Inhibitory neurons: %d\n',...
            length(find(neuron_type)),length(find(neuron_type-1)))

end