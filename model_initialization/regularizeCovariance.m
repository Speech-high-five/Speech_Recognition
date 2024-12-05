function regularizedCov = regularizeCovariance(covMatrix, epsilon)
% REGULARIZECOVARIANCE Summary of this function goes here
%
% [OUTPUTARGS] = REGULARIZECOVARIANCE(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/05 19:02:12
% Revision: 0.1

% Validate inputs
if ~ismatrix(covMatrix) || size(covMatrix, 1) ~= size(covMatrix, 2)
    error('Input must be a square covariance matrix.');
end

if epsilon <= 0
    error('Regularization term epsilon must be a positive scalar.');
end

% Add epsilon to the diagonal elements
regularizedCov = covMatrix + epsilon * eye(size(covMatrix));

% Ensure symmetry (numerical stability)
regularizedCov = (regularizedCov + regularizedCov') / 2;
end
