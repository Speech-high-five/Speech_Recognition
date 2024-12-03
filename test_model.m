%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/11/2024 23:05

clc;
close all;
clear;

D = 13;

% Load test data
% testDataFile = GlobalSetting.TEST_DATA;
% testData = load(testDataFile, 'testData').testData;

% Load evaluation data
evaluationDataFile = GlobalSetting.EVALUATION_DATA;
evaluationData = load(evaluationDataFile, 'evaluationData').evaluationData;

% Load HMM model
hmm_model = load(GlobalSetting.HMM_MODEL, 'hmm').hmm;
WORDS = GlobalSetting.WORDS;
words_len = length(WORDS);

Ndata = size(evaluationData,2);
% Ndata = size(testData,2);

p = 0;
n = 0;
for i=1:Ndata
    data = evaluationData(:,i);
    sampleData = data.sampleData;
    sampleRate = data.sampleRate;
    true_word = data.word;
    % Compute MFCC coefficients
    mfccCoeff = mfccFeature(sampleData, sampleRate, D);
    % mfccCoeff=mfccCoeff';

    % Recognize the word
    for j=1:words_len
        word = WORDS{j};
        hmm = hmm_model.(word);
        pout(j) = viterbi(hmm, mfccCoeff);
    end
    [d,n] = max(pout);

    word_res = WORDS{n};
    fprintf('The NO. %d word is recognized as %s\n', i-1,word_res)
    if strcmp(word_res, true_word)
        p = p+1;
        fprintf('The recognition is correct\n')
    else
      n = n+1;
        fprintf('The recognition is incorrect\n')
    end

end

accuracy = p/Ndata;
fprintf('The recognition rate is %f\n', accuracy)

