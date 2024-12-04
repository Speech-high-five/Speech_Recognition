%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 04/12/2024 17:12

clc;
close all;
clear;

% Characteristics and Evaluation Results of Validation Data:
%
% Characteristics of Validation Data:
% The pronunciations in the validation dataset consist entirely of male voices across 11 groups of words.
%
% Evaluation Results of Validation Data:
% 	•	The prediction accuracy for “had” and “hard” is 0%.
% 	•	The prediction accuracy for “heard” and “whod” is 10%.
% 	•	The prediction accuracy for “hid” and “hoard” is relatively high, at 90% and 100%, respectively.
%
% Enhancement Measures for the Data:
% 	1.	Train only on male voices.
% 	2.	Perform 2x or 3x repetition augmentation for male voice recordings.
% 	3.	Perform 2x or 3x repetition augmentation for audio samples of the words “had,” “hard,” “heard,” and “whod.”

% Male voice prefixes
manPrefix = {'sp01a', 'sp03a', 'sp05a', 'sp07a', 'sp11a', 'sp13a', 'sp14a', 'sp15a', 'sp17a', 'sp22a', 'sp24a', 'sp26a', 'sp28a', 'sp30a'};
womanPrefix = {'sp02a', 'sp04a', 'sp06a', 'sp08a', 'sp09a', 'sp10a', 'sp12a', 'sp16a', 'sp18a', 'sp19a', 'sp20a', 'sp23a', 'sp25a', 'sp27a', 'sp29a'};
childPrefix = {'sp21a'};


% Set the train ratio
trainRatio = 1;

manPrefixLen = length(manPrefix);
numManTrain = round(trainRatio*manPrefixLen);
randManIndex = randperm(manPrefixLen);
trainManPrefix = manPrefix(randManIndex(1:numManTrain));

% womanPrefixLen = length(womanPrefix);
% numWomanTrain = round(trainRatio*womanPrefixLen);
% randWomanIndex = randperm(womanPrefixLen);
% trainWomanPrefix = womanPrefix(randWomanIndex(1:numWomanTrain));

% Get all the audio files
datasetFolder = GlobalSetting.DATASET_FOLDER;
allFiles = dir(fullfile([datasetFolder,'/*.mp3']));
filesLen = length(allFiles);

% Define training and testing data
trainData = struct('name', {}, 'path', {}, 'gender', {}, 'word', {}, 'sampleData', {}, 'sampleRate', {}');

% Specify the repetition factor
repetitionFactor = 5;
repetitionFactor_word = 3;

% Get all words
WORDS = GlobalSetting.WORDS;
words_len = length(WORDS);

% special_words = {'had', 'hard', 'whod', 'heard'};
special_words = {'had', 'head'};

% Loop through all files to categorize them into training and testing sets.
for i = 1:filesLen
    fileName = allFiles(i).name;
    fileNameSplited = split(fileName, "_");
    filePrefix = fileNameSplited{1};
    word = fileNameSplited{3};
    wordSplited = split(word, ".");
    word = wordSplited{1};
    filePath = [datasetFolder '/' fileName];
    [y,Fs]=audioread(filePath);

    if ismember(filePrefix, trainManPrefix)
        % Repeat the male data
        for j = 1:repetitionFactor
            trainData(end+1).name = fileName;
            trainData(end).path = filePath;
            trainData(end).gender = 'man';
            trainData(end).word = word;
            trainData(end).sampleData = y;
            trainData(end).sampleRate = Fs;
        end

        % Repeat the special words
        if ismember(word, special_words)
            for j = 1:repetitionFactor_word
                trainData(end+1).name = fileName;
                trainData(end).path = filePath;
                trainData(end).gender = 'man';
                trainData(end).word = word;
                trainData(end).sampleData = y;
                trainData(end).sampleRate = Fs;
            end
        end
    % elseif ismember(filePrefix, trainWomanPrefix)
    %     trainData(end+1).name = fileName;
    %     trainData(end).path = filePath;
    %     trainData(end).gender = 'woman';
    %     trainData(end).word = word;
    %     trainData(end).sampleData = y;
    %     trainData(end).sampleRate = Fs;
    % else
    %     trainData(end+1).name = fileName;
    %     trainData(end).path = filePath;
    %     trainData(end).gender = 'child';
    %     trainData(end).word = word;
    %     trainData(end).sampleData = y;
    %     trainData(end).sampleRate = Fs;
    end

end

% Save the training and testing data to files
saveDir = GlobalSetting.DATA_AUGMENTATION;
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end
savePath=[saveDir, '/data_augmentation_male__x5_word_x3.mat'];
save(savePath, 'trainData');
