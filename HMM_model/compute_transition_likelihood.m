function [ksai] = compute_transition_likelihood(T, N, c, mix, trans, observations, alpha, beta)
% COMPUTE_TRANSITION_LIKELIHOOD Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTE_TRANSITION_LIKELIHOOD(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/04 10:37:05 
% Revision: 0.1 

% The transition probability ksai, i.e. A.
ksai = zeros(T-1,N,N);
for t = 1:T-1
    denom = sum(alpha(t,:).*beta(t,:));
    for i = 1:N-1
    	for j = i:i+1
    		nom = alpha(t,i) * trans(i,j) * compute_probability(mix(j),observations(t+1,:)) * beta(t+1,j);
    		ksai(t,i,j) = c(t) * nom/denom;
    	end
    end
end

end
