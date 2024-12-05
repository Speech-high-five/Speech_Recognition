function [meanData, varianceData] = meanVariance(mfccCoeff)
% MEANVARIANCE Calculate the mean and variance of MFCC coefficients.
%
% [MEANDATA, VARIANCEDATA] = MEANVARIANCE(MFCCCOEFF) computes the mean and variance
% of the input MFCC coefficients matrix. The input matrix has dimensions D x M,
% where D is the number of MFCC coefficients and M is the number of observations.
% The function returns two matrices, MEANDATA and VARIANCEDATA, each of size D x D,
% containing the mean and variance values, respectively.
%
% Examples:
%   mfccCoeff = rand(13, 100); % Example MFCC coefficients matrix (13 coefficients, 100 observations)
%   [meanData, varianceData] = meanVariance(mfccCoeff);
%   disp(meanData);
%   disp(varianceData);
%
% See also: mfcc, featureExtraction

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/22 23:28:41
% Revision: 0.1

% Get the dimensions of the input MFCC coefficients matrix
[D, M] = size(mfccCoeff);  % M : number of observations

% Initialize the mean and variance data matrices
meanData = zeros(D, D);
varianceData = zeros(D, D);

% Calculate the number of observations per segment
k = floor(M / D);

% Loop through each segment to calculate the mean and variance
for i = 1:D-1
    % Calculate the mean and variance for the current segment
    meanData(:, i) = mean(mfccCoeff(:, k * (i - 1) + 1:i * k), 2);
    varianceData(:, i) = var(mfccCoeff(:, k * (i - 1) + 1:i * k), 0, 2);
end

% Handle the last segment, which may have fewer observations
i = D;
meanData(:, i) = mean(mfccCoeff(:, k * (i - 1) + 1:end), 2);
varianceData(:, i) = var(mfccCoeff(:, k * (i - 1) + 1:end), 0, 2);

% Normalize the mean and variance
meanData = normalizeMatrix(meanData);
varianceData = normalizeMatrix(varianceData);

% Regulate the variance
% Regularization parameter
epsilon = 1e-8;
varianceData = regularizeCovariance(varianceData, epsilon);

end