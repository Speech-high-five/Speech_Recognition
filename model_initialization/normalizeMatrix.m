function normalizedMatrix = normalizeMatrix(matrix, method)
% NORMALIZEMATRIX Summary of this function goes here
%
% [OUTPUTARGS] = NORMALIZEMATRIX(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/05 19:01:05
% Revision: 0.1

% Default method if none is provided
if nargin < 2
    method = 'minmax';
end

switch lower(method)
    case 'minmax'
        % Min-max normalization: scale values to [0, 1]
        minVal = min(matrix(:));
        maxVal = max(matrix(:));
        if maxVal == minVal
            warning('Matrix has no variation. Returning zero matrix.');
            normalizedMatrix = zeros(size(matrix));
        else
            normalizedMatrix = (matrix - minVal) / (maxVal - minVal);
        end

    case 'zscore'
        % Z-score normalization: mean = 0, standard deviation = 1
        meanVal = mean(matrix(:));
        stdVal = std(matrix(:));
        if stdVal == 0
            warning('Matrix has no variation. Returning zero matrix.');
            normalizedMatrix = zeros(size(matrix));
        else
            normalizedMatrix = (matrix - meanVal) / stdVal;
        end

    otherwise
        error('Unsupported normalization method. Use ''minmax'' or ''zscore''.');
end
end
