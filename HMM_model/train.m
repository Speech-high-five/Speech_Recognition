function [hmm, all_errors] = train(samples, M)
% TRAIN Summary of this function goes here
%
% [OUTPUTARGS] = TRAIN(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/03 00:04:26
% Revision: 0.1

D = GlobalSetting.D;
K   = length(samples);

% Calculate MFCCs
disp('Calculating MFCCs...');
for k = 1:K
    if isfield(samples(k),'data') & ~isempty(samples(k).data)
        continue;
    else
        sampleData = samples(k).sampleData;
        sampleRate = samples(k).sampleRate;
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        samples(k).data = mfccCoeff;
    end
end

hmm = init_hmm(samples, M);
% hmm = init_hmm_with_kmeans(samples, M);

for loop = 1:GlobalSetting.EPOCHS
    fprintf('Starting Epoch %d ... \n', loop)
    hmm = Baum_Welch(hmm, samples);

    % Compute total output probability
    pout(loop)=0;
    for k = 1:K
        [viterbi_res, ~] = viterbi(hmm, samples(k).data);
        pout(loop) = pout(loop) + viterbi_res;
    end

    fprintf('Sum of the output probabilities (log)=%d\n', pout(loop));

    % Compare the distance between two HMMs.
    if loop>1
        if abs((pout(loop)-pout(loop-1))/pout(loop)) < 2e-5
            fprintf('The model converges!\n');
            return
        end
    end
end

fprintf('After %d iterations without convergence, exit.\n', GlobalSetting.EPOCHS);

