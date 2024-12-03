function [hmm] = init_hmm(samples, M)
% INIT_HMM Summary of this function goes here
% 
% [OUTPUTARGS] = INIT_HMM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/03 00:08:58 
% Revision: 0.1 

% The number of samples
K = length(samples);
% The number of states
N = length(M);
hmm.N = N;
hmm.M = M;

% Initial state probabilities
hmm.init = GlobalSetting.Pi_init

% Transition probabilities A
hmm.trans=GlobalSetting.A_init

for k = 1:K
  % Compute mean and variance
  mfccCoeff = samples(k).data;
  mfccCoeff=mfccCoeff';
  [meanData, varianceData] =meanVariance(mfccCoeff);
  mix(i).mean = meanData;
  mix(i).var = varianceData;
end

hmm.mix = mix;

