function [param] = get_param(hmm, O)
% GET_PARAM Summary of this function goes here
% 
% [OUTPUTARGS] = GET_PARAM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/03 00:33:41 
% Revision: 0.1 

% The length of sequence
T = size(O,1);
% Initial Pi
init  = hmm.init;
% Initial A
trans = hmm.trans;
% Gaussian Mixture states
mix   = hmm.mix;
% HMM states
N     = hmm.N;

% Given the observation sequence, calculate the forward probability.
alpha = zeros(T,N);

% The forward probability at t = 1.
x = O(1,:);
for i = 1:N
	alpha(1,i) = init(i) * mixture(mix(i),x);
end

% Initialize the forward probability for t = 1.
c    = zeros(T,1);
c(1) = 1/sum(alpha(1,:));
alpha(1,:) = c(1) * alpha(1,:);

% The forward probabilities and initialization for t = 2 to T.
for t = 2:T
	for i = 1:N
		temp = 0;
		for j = 1:N
			temp = temp + alpha(t-1,j) * trans(j,i);
		end
		alpha(t,i) = temp * mixture(mix(i),O(t,:));
	end
	c(t) = 1/sum(alpha(t,:));
	alpha(t,:) = c(t)*alpha(t,:);
end

% Given the observation sequence O, calculate the backward probabilities beta.
beta = zeros(T,N);

% The backward probability at t = T and its normalization.
for l = 1:N
	beta(T,l) = c(T);	
end

% The backward probabilities from t = T -1 to t = 1 and their normalization.
for t = T-1:-1:1
	x = O(t+1,:);
	for i = 1:N
	for j = 1:N
		beta(t,i) = beta(t,i) + beta(t+1,j) * mixture(mix(j),x) * trans(i,j);
	end
	end
	beta(t,:) = c(t) * beta(t,:);
end

%¹The transition probability ksai.
ksai = zeros(T-1,N,N);
for t = 1:T-1
	denom = sum(alpha(t,:).*beta(t,:));
	for i = 1:N-1
	for j = i:i+1
		nom = alpha(t,i) * trans(i,j) * mixture(mix(j),O(t+1,:)) * beta(t+1,j);
		ksai(t,i,j) = c(t) * nom/denom;
	end
	end
end

% The mixture output probability: gama.
gama = zeros(T,N,max(hmm.M));
for t = 1:T
	pab = zeros(N,1);
	for l = 1:N
		pab(l) = alpha(t,l) * beta(t,l);
	end
	x = O(t,:);
	for l = 1:N
		prob = zeros(mix(l).M,1);
		for j = 1:mix(l).M
			m = mix(l).mean(j,:);
			v = mix(l).var (j,:);
			prob(j) = mix(l).weight(j) * get_pdf(m, v, x);
		end
		tmp  = pab(l)/sum(pab);
		for j = 1:mix(l).M
			gama(t,l,j) = tmp * prob(j)/sum(prob);
		end
	end
end

param.c     = c;
param.alpha = alpha;
param.beta  = beta;
param.ksai  = ksai;
param.gama  = gama;

