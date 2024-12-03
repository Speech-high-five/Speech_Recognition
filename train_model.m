%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%%         Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%%                za00632@surrey.ac.uk
%% Time: 22/11/2024 17:44
%%       28/11/2024 15:55
close all;
clear;

% Load train data
trainDataFile = GlobalSetting.TRAIN_DATA;
trainData = load(trainDataFile, 'trainData').trainData;
Ntrain=size(trainData,2);

% The state of HMM model
N = GlobalSetting.N;

WORDS = GlobalSetting.WORDS;
words_len = length(WORDS);

wordData = {trainData.word};
sampleDataset = {trainData.sampleData};
sampleRateData = {trainData.sampleRate};
sampleRate = 16000;

for i=1:words_len
    word = WORDS{i};
    % Find the index of word
    idxes = find(strcmp(wordData, word));
    
    samples = trainData(idxes);
    % The number of pdf in each state
    PDFS = [N N N N N N N N];
    hmm{i}=train(samples,PDFS);

end

% % Convert cell array to struct
hmm = cell2struct(hmm', WORDS, 1);
model_file = GlobalSetting.HMM_MODEL;
save(model_file, 'hmm');

