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
hmm.init = GlobalSetting.Pi_init;

% Transition probabilities A
hmm.trans = GlobalSetting.A_init;

% Make N segements
for k = 1:K
    T = size(samples(k).data,1);
    samples(k).segment=floor([1:T/N:T T+1]);
end

% Obtain a continuous Gaussian mixture distribution.
for i = 1:N
    % Combine vectors with the same cluster and the same state into a single vector.
    vector = [];
    nn = [];
    for k = 1:K
        seg1 = samples(k).segment(i);
        seg2 = samples(k).segment(i+1)-1;
        segment_data = samples(k).data(seg1:seg2,:);
        tmp_nn = repmat(k,1,size(segment_data,1))';
        nn = [nn ; tmp_nn];
        vector = [vector ; segment_data];
    end
    mix(i) = Gussian_mix(vector, M(i), nn);
end

hmm.mix = mix;
