function [prob] = compute_probability(mix, x)
% MIXTURE Summary of this function goes here
%
% [OUTPUTARGS] = MIXTURE(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 00:30:05
% Revision: 0.1

prob = 0;
for j = 1:mix.M
    m = mix.mean(j,:);
    v = mix.var (j,:);
    w = mix.weight(j);
    prob = prob + w * compute_pdf(m, v, x);
end

% Add realmin to prevent overflow when calculating log(prob) in viterbi.m.
if prob==0, prob=realmin; end
