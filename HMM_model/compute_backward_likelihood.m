function [beta] = compute_backward_likelihood(T, N, c, mix, trans, observations)
% COMPUTE_BACKWARD_LIKELIHOOD Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTE_BACKWARD_LIKELIHOOD(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/04 10:36:16 
% Revision: 0.1 

% Given the observation sequence O, calculate the backward probabilities beta.
beta = zeros(T,N);

% The backward probability at t = T and its normalization.
for l = 1:N
    beta(T,l) = c(T);
end

% The backward probabilities from t = T -1 to t = 1 and their normalization.
for t = T-1:-1:1
    x = observations(t+1,:);
    for i = 1:N
    	for j = 1:N
    		beta(t,i) = beta(t,i) + beta(t+1,j) * compute_probability(mix(j),x) * trans(i,j);
    	end
    end
    beta(t,:) = c(t) * beta(t,:);
    % Scale the backward probabilities
    beta(t,:) = beta(t,:)/sum( beta(t,:));
end

% Avoid getting NaN
beta(isnan(beta))=GlobalSetting.REPLACE_NAN;
end
