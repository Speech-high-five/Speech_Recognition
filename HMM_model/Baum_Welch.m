function [hmm] = Baum_Welch(hmm, samples)
% BAUM_WELCH Summary of this function goes here
%
% [OUTPUTARGS] = BAUM_WELCH(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 00:11:46
% Revision: 0.1

% Gaussian Mixture states
mix = hmm.mix;
% HMM states
N = length(mix);
% Number of samples
K = length(samples);
% Parameter dimension
SIZE = size(samples(1).data,2);

% Compute forward and backward probabilities
for k = 1:K
    % fprintf('%d ',k)
    likelihoods(k) = obtain_likelihoods(hmm, samples(k).data);
end
% fprintf('\n')

% Re-estimate transition probability matrix A
disp('Re-estimate transition probability matrix A...')
for i = 1:N-1
    denom = 0;
    for k = 1:K
        tmp   = likelihoods(k).ksai(:,i,:);
        denom = denom + sum(tmp(:));
    end
    for j = i:i+1
        nom = 0;
        for k = 1:K
            tmp = likelihoods(k).ksai(:,i,j);
            nom = nom   + sum(tmp(:));
        end
        hmm.trans(i,j) = nom / denom;
    end
end

% Re-estimate the parameters of Gaussian mixture
disp('Re-estimate the parameters of Gaussian mixture...')
for l = 1:N
    for j = 1:hmm.M(l)
        % fprintf('%d,%d ',l,j)
        % Compute mean and variance of pdf
        nommean = zeros(1,SIZE);
        nomvar  = zeros(1,SIZE);
        denom   = 0;
        for k = 1:K
            T = size(samples(k).data,1);
            for t = 1:T
                x	    = samples(k).data(t,:);
                nommean = nommean + likelihoods(k).gama(t,l,j) * x;
                nomvar  = nomvar  + likelihoods(k).gama(t,l,j) * (x-mix(l).mean(j,:)).^2;
                denom   = denom   + likelihoods(k).gama(t,l,j);
            end
        end
        hmm.mix(l).mean(j,:) = nommean / denom;
        hmm.mix(l).var (j,:) = nomvar  / denom;

        % Compute the weight of pdf
        nom   = 0;
        denom = 0;
        for k = 1:K
            tmp = likelihoods(k).gama(:,l,j);    nom   = nom   + sum(tmp(:));
            tmp = likelihoods(k).gama(:,l,:);    denom = denom + sum(tmp(:));
        end
        hmm.mix(l).weight(j) = nom/denom;
    end
    % fprintf('\n')
end
