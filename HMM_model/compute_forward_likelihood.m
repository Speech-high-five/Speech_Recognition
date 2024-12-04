function [alpha, c] = compute_forward_likelihood(T, N, init, mix, trans, observations)
% COMPUTE_FORWARD_LIKELIHOOD Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTE_FORWARD_LIKELIHOOD(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/04 10:36:02 
% Revision: 0.1 

% Given the observation sequence, calculate the forward probability.
alpha = zeros(T,N);

% The forward probability at t = 1.
x = observations(1,:);
for i = 1:N
    alpha(1,i) = init(i) * compute_probability(mix(i),x);
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
        alpha(t,i) = temp * compute_probability(mix(i),observations(t,:));
    end
    % Scale the forward probabilities.
    c(t) = 1/sum(alpha(t,:));
    alpha(t,:) = c(t)*alpha(t,:);
end

% Avoid getting NaN
c(isnan(c))=GlobalSetting.REPLACE_NAN;
alpha(isnan(alpha))=GlobalSetting.REPLACE_NAN;
end
