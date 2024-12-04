function [gama] = compute_occupation_likelihood(T, N, mix, hmm, observations, alpha, beta)
% COMPUTE_OCCUPATION_LIKELIHOOD Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTE_OCCUPATION_LIKELIHOOD(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/04 10:36:37 
% Revision: 0.1 

% The mixture output probability: gama, i.e B.
gama = zeros(T,N,max(hmm.M));
for t = 1:T
    pab = zeros(N,1);
    for l = 1:N
        pab(l) = alpha(t,l) * beta(t,l);
    end
    x = observations(t,:);
    for l = 1:N
        prob = zeros(mix(l).M,1);
        for j = 1:mix(l).M
            m = mix(l).mean(j,:);
            v = mix(l).var (j,:);
            prob(j) = mix(l).weight(j) * compute_pdf(m, v, x);
        end
        tmp  = pab(l)/sum(pab);
        for j = 1:mix(l).M
            gama(t,l,j) = tmp * prob(j)/sum(prob);
        end
    end
end



end
