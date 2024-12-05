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

% Calculate MFCCs
disp('Calculating MFCCs...');
for k = 1:K
    if isfield(trainData(k),'data') & ~isempty(trainData(k).data)
        continue;
    else
        sampleData = trainData(k).sampleData;
        sampleRate = trainData(k).sampleRate;
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        trainData(k).data = mfccCoeff;
    end
end

% Train HMM model
epochs = GlobalSetting.EPOCHS;
all_errors = zeros(epochs, 1);
hmm_models = struct();
lowest_error = 1;

for loop = 1:epochs
    fprintf('Starting Epoch %d ... \n', loop)
    % Run training with different group data based on different word.
    for i=1:words_len
        word = WORDS{i};
        fprintf('Start training %s group data\n', word);
        % Find the index of word
        idxes = find(strcmp(wordData, word));

        samples = trainData(idxes);
        % The number of pdf in each state
        PDFS = repmat(D, 1, N);
        if loop == 1
            hmm = init_hmm(samples, PDFS);
        else
            % update hmm model
            hmm = hmm_models.(word);
        end
        hmm_models.(word)=Baum_Welch(hmm, samples);
    end

    % Evaluate the model
    v_output(loop)=0;
    for k = 1:K_test
        data = testData(:,k);
        sampleData = data.sampleData;
        sampleRate = data.sampleRate;
        % Compute MFCC coefficients
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        for j=1:words_len
            word = WORDS{j};
            hmm = hmm_models.(word);
            [viterbi_res, ~] = viterbi(hmm, mfccCoeff);
            pout(j) = viterbi_res;
            v_output(loop) = v_output(loop) + viterbi_res;
        end
        [d,n] = max(pout);
        word_res = WORDS{n};
        testData(k).prediction = word_res;
    end

    % Compute error rate
    trueSequence = {testData.word};
    predictedSequence = {testData.prediction};
    [errorRate] = compute_error_rate(trueSequence, predictedSequence);
    all_errors(loop) = errorRate;

    fprintf('%d Epoch, The recognition error rate is %f\n', loop, errorRate)

    % Update the best model if current error rate is lower than the best one
    if errorRate <= lowest_error
        lowest_error = errorRate;
        best_hmm = hmm_models;
        fprintf('New best model found: model of loop %d !\n', loop);
    end

    % Convergence monitoring
    % Compare the distance between two HMMs.
    if loop>1
        difference = abs((v_output(loop)-v_output(loop-1))/v_output(loop));
        fprintf('Difference of the viterbi output = %d\n', difference);
        if  difference < 2e-5
            fprintf('The model converges!\n');
            % break
        end
    end

    % Save the HMM model
    saveDir = GlobalSetting.HMM_MODEL;
    if ~exist(saveDir, 'dir')
        % Create the new directory
        mkdir(saveDir);
    end

    str_loop = num2str(loop);
    model_file = [saveDir, '/hmm_models_', str_loop, '.mat'];
    % model_file = strjoin(model_file, '');
    save(model_file, 'hmm_models');

end

% Plot the error rate
epoch_list = 1:epochs;
plot_errors(epoch_list, all_errors);


