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
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x1.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x2.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x3.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x5.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x10.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_x50.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_word_x2.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_word_x5.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male_word_x5.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male__x5_female.mat'];
% trainDataFile = [GlobalSetting.DATA_AUGMENTATION, '/data_augmentation_male__x5_word_x3.mat'];
trainData = load(trainDataFile, 'trainData').trainData;
K=size(trainData,2);

% Load test data
testDataFile = GlobalSetting.TEST_DATA;
testData = load(testDataFile, 'testData').testData;
K_test=size(testData,2);

% The state of HMM model
N = GlobalSetting.N;
% Parameter dimension
D = GlobalSetting.D;

WORDS = GlobalSetting.WORDS;
words_len = length(WORDS);

wordData = {trainData.word};

% Split data into different groups based on 11 word
% group_data = struct();

% for i=1:words_len
%   word = WORDS{i};
%   fprintf('Start training %s group data\n', word);
%   % Find the index of word
%   idxes = find(strcmp(wordData, word));
%
%   samples = trainData(idxes);
% end

% Slice the struct array from index 1 to 11
% Run training with different group data based on sliced data.
index = 1:11:K;
for i = 1:length(index)
    inx = index(i);
    sliced_data = trainData(i:i+10);
    fprintf('Start training %d group data', i);
    % The number of pdf in each state
    PDFS = repmat(D, 1, N);
    hmm=train(sliced_data,PDFS);
end

% % Convert cell array to struct
% hmm = cell2struct(hmm', WORDS, 1);
model_file = [GlobalSetting.HMM_MODEL, '/hmm_models_mix.mat'];
save(model_file, 'hmm');