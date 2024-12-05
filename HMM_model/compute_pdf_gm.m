function [p] = compute_pdf_gm(m, v, x)
% GET_PDF Summary of this function goes here
%
% [OUTPUTARGS] = GET_PDF(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 00:35:32
% Revision: 0.1

% Regularization to prevent zero variances
epsilon = 1e-8; % Small value to prevent numerical instability
v = v + epsilon;

% Dimension of the data
D = length(v);

% Check for consistency in dimensions
if length(m) ~= D || length(x) ~= D
    error('Mean, variance, and data point must have the same dimension.');
end

% Normalization factor
norm_factor = (2 * pi) ^ (-D / 2) * prod(v .^ -0.5);

% Compute the exponent
diff = x - m;
exponent = -0.5 * sum((diff .^ 2) ./ v);

% Avoid overflow/underflow in exponential
exponent = max(exponent, -700); % Prevent exp(-inf) (numerical limit of exp in MATLAB)

% Compute the probability
p = norm_factor * exp(exponent);

% Avoid probabilities smaller than realmin
p = max(p, realmin);

% Avoid getting NaN
if isnan(p), p=GlobalSetting.REPLACE_NAN; end

end
