function [errorRate] = compute_error_rate(trueSequence, predictedSequence)
% COMPUTE_ERROR_RATE Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTE_ERROR_RATE(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/04 20:56:48 
% Revision: 0.1 

% Calculate the number of mismatches
% Ensure the two cells are of the same size
if length(trueSequence) ~= length(predictedSequence)
  error('The two cells must have the same length for comparison.');
end

% Initialize mismatch counter
numErrors = 0;

% Loop through each element to compare
for i = 1:length(trueSequence)
  if ~strcmp(trueSequence{i}, predictedSequence{i})
    numErrors = numErrors + 1;
  end
end

% Calculate the total number of observations
totalObservations = length(trueSequence);

% Calculate error rate
errorRate = numErrors / totalObservations;

end
