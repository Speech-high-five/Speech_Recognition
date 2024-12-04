function [likelihoods] = obtain_likelihoods(hmm, observations)
% GET_PARAM Summary of this function goes here
%
% [OUTPUTARGS] = GET_PARAM(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 00:33:41
% Revision: 0.1

% The length of sequence
T = size(observations,1);
% Initial Pi
init  = hmm.init;
% Initial A
trans = hmm.trans;
% Gaussian Mixture states
mix   = hmm.mix;
% HMM states
N     = hmm.N;

% Given the observation sequence, calculate the forward probability.
[alpha, c] = compute_forward_likelihood(T, N, init, mix, trans, observations);

% Given the observation sequence O, calculate the backward probabilities beta.
[beta] = compute_backward_likelihood(T, N, c, mix, trans, observations);

% The transition probability ksai, i.e. A.
[ksai] = compute_transition_likelihood(T, N, c, mix, trans, observations, alpha, beta);

% The mixture output probability: gama, i.e B.
[gama] = compute_occupation_likelihood(T, N, mix, hmm, observations, alpha, beta);

likelihoods.c     = c;
likelihoods.alpha = alpha;
likelihoods.beta  = beta;
likelihoods.ksai  = ksai;
likelihoods.gama  = gama;

