function [mix] = Gussian_mix(vector, M, nn)
% GUSSIAN_MIX Summary of this function goes here
%
% [OUTPUTARGS] = GUSSIAN_MIX(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 19:56:54
% Revision: 0.1

[mean, var] = meanVariance(vector');
mean = mean';
var = var';

% Calculate the number of elements in each cluster and normalize them to obtain the weights for each PDF.
weight = zeros(M,1);
for j = 1:M
    weight(j) = sum(find(j==nn));
end
weight = weight/sum(weight);

% Save the results.
mix.M      = M;
mix.mean   = mean;
mix.var    = var;
mix.weight = weight;

end
