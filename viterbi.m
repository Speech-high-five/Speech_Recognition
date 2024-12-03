function [prob] = viterbi(hmm, O)
% VITERBI Summary of this function goes here
% 
% [OUTPUTARGS] = VITERBI(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/03 00:15:17 
% Revision: 0.1 

% Inital Pi
init  = hmm.init;
% Initial A
trans = hmm.trans;
% Gussian mix 
mix   = hmm.mix;
% HMM states
N     = hmm.N;		%HMM״̬��
% The number of samples
T     = size(O,1);

% Compute log(init)
ind1  = find(init>0);
ind0  = find(init<=0);
init(ind0) = -inf;
init(ind1) = log(init(ind1));

% Compute log(trans)
ind1 = find(trans>0);
ind0 = find(trans<=0);
trans(ind0) = -inf;
trans(ind1) = log(trans(ind1));

% Initialize
delta = zeros(T,N);
fai   = zeros(T,N);
q     = zeros(T,1);

% t=1
x = O(1,:);
for i = 1:N
	delta(1,i) = init(i) + log(mixture(mix(i),x));
end

% t=2:T
for t = 2:T
for j = 1:N
	[delta(t,j) fai(t,j)] = max(delta(t-1,:) + trans(:,j)');
	x = O(t,:);
	delta(t,j) = delta(t,j) + log(mixture(mix(j),x));
end
end

% The final probability and the last node
[prob q(T)] = max(delta(T,:));

% Backtrack the best state path.
for t=T-1:-1:1
	q(t) = fai(t+1,q(t+1));
end

