function [hmm] = init_hmm(samples, M)
% INIT_HMM Summary of this function goes here
% 
% [OUTPUTARGS] = INIT_HMM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/03 00:08:58 
% Revision: 0.1 

% The number of samples
K = length(samples);
% The number of states
N = length(M);
hmm.N = N;
hmm.M = M;

% Initial state probabilities
hmm.init = GlobalSetting.Pi_init';

% Transition probabilities A
hmm.trans = GlobalSetting.A_init;

% Make cluster for the data
% Make segements
for k = 1:K
	T = size(samples(k).data,1);
	samples(k).segment=floor([1:T/N:T T+1]);
end

% Perform K-means clustering on the vectors belonging to each state to obtain a continuous Gaussian mixture distribution.
for i = 1:N
  % Combine vectors with the same cluster and the same state into a single vector.
	vector = [];
	for k = 1:K
		seg1 = samples(k).segment(i);
		seg2 = samples(k).segment(i+1)-1;
        segment_data = samples(k).data(seg1:seg2,:);
		vector = [vector ; segment_data];
	end
	mix(i) = getmix(vector, M(i));
end

hmm.mix = mix;

function mix = getmix(vector, M)

[mean esq nn] = kmeans(vector,M);

% Calculate the standard deviation of each cluster, form a diagonal matrix, and retain only the elements on the diagonal.
for j = 1:M
	ind = find(j==nn);
	tmp = vector(ind,:);
	var(j,:) = std(tmp);
end

% Calculate the number of elements in each cluster and normalize them to obtain the weights for each PDF.
weight = zeros(M,1);
for j = 1:M
	weight(j) = sum(find(j==nn));
end
weight = weight/sum(weight);

% Save the results.
mix.M      = M;
mix.mean   = mean;		% M*SIZE
mix.var    = var.^2;	% M*SIZE
mix.weight = weight;	% M*1

