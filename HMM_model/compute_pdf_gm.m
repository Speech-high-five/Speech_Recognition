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

% Validate inputs
if length(m) ~= length(v) || length(m) ~= length(x)
    error('Mean, variance, and data point must have the same dimension.');
end

% Regularization: Add a small constant to the variance
epsilon = 1e-8; % Small positive constant
v = max(v, epsilon); % Ensure variance is not too small or zero

% Compute normalization factor
D = length(v); % Dimension of the data
norm_factor = (2 * pi) ^ (-D / 2) * prod(v .^ -0.5);

% Compute the exponent
diff = x - m; % Difference between the data point and the mean
scaled_diff = diff .^ 2 ./ v; % Element-wise scaling by variance
exponent = -0.5 * sum(scaled_diff); % Summation across dimensions

% Clamp exponent to prevent underflow/overflow
exponent = max(min(exponent, 700), -700); % Avoid overflow in `exp`

% Compute final probability
p = norm_factor * exp(exponent);

% Avoid probabilities smaller than realmin
p = max(p, realmin); % Ensure p is not smaller than MATLAB's smallest positive float

% Avoid getting NaN
if isnan(p), p=GlobalSetting.REPLACE_NAN; end

end
