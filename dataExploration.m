%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/11/2024 16:24

clc;
close all;
clear;

% Set the train ratio
trainRatio = 0.8;
% trainRatio = 1;

% By observing the data, we can find that the dataset contains a total of 
% 30 groups of data, with each group consisting of 11 pieces of data. 
% Each group represents the pronunciations of 11 words by the same person. 
% Among the 30 groups, the voice types include male voices, female voices, 
% and children’s voices, with 14 groups being male voices, 15 groups 
% female voices, and 1 group children’s voices. 

% Based on the identical prefixes of each group’s files, the following 
% classifications can be determined.
manPrefix = {'sp01a', 'sp03a', 'sp05a', 'sp07a', 'sp11a', 'sp13a', 'sp14a', 'sp15a', 'sp17a', 'sp22a', 'sp24a', 'sp26a', 'sp28a', 'sp30a'};
womanPrefix = {'sp02a', 'sp04a', 'sp06a', 'sp08a', 'sp09a', 'sp10a', 'sp12a', 'sp16a', 'sp18a', 'sp19a', 'sp20a', 'sp23a', 'sp25a', 'sp27a', 'sp29a'};
childPrefix = {'sp21a'};


% Split the data into training and testing sets, based on different genders
% Because children’s voices only have one sample, just put it into train data
manPrefixLen = length(manPrefix);
numManTrain = round(trainRatio*manPrefixLen);
randManIndex = randperm(manPrefixLen);
trainManPrefix = manPrefix(randManIndex(1:numManTrain)); 

womanPrefixLen = length(womanPrefix);
numWomanTrain = round(trainRatio*womanPrefixLen);
randWomanIndex = randperm(womanPrefixLen);
trainWomanPrefix = womanPrefix(randWomanIndex(1:numWomanTrain)); 

% Split dataset based on prefix data
datasetFolder = GlobalSetting.DATASET_FOLDER;
allFiles = dir(fullfile([datasetFolder,'/*.mp3']));
filesLen = length(allFiles);

numTrainFiles = numManTrain+numWomanTrain+1;

% Define training and testing data
trainData = struct('name', {}, 'path', {}, 'gender', {}, 'word', {}, 'sampleData', {}, 'sampleRate', {}');
testData = struct('name', {}, 'path', {}, 'gender', {}, 'word', {}, 'sampleData', {}, 'sampleRate', {}');

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
        trainData(end+1).name = fileName;
        trainData(end).path = filePath;
        trainData(end).gender = 'man';
        trainData(end).word = word;
        trainData(end).sampleData = y;
        trainData(end).sampleRate = Fs;
    elseif ismember(filePrefix, trainWomanPrefix)
        trainData(end+1).name = fileName;
        trainData(end).path = filePath;
        trainData(end).gender = 'woman';
        trainData(end).word = word;
        trainData(end).sampleData = y;
        trainData(end).sampleRate = Fs;
    elseif ismember(filePrefix, childPrefix)
        trainData(end+1).name = fileName;
        trainData(end).path = filePath;
        trainData(end).gender = 'child';
        trainData(end).word = word;
        trainData(end).sampleData = y;
        trainData(end).sampleRate = Fs;
    else
        testData(end+1).name = fileName;
        testData(end).path = filePath;
        testData(end).gender = 'man';
        testData(end).word = word;
        testData(end).sampleData = y;
        testData(end).sampleRate = Fs;
    end
end


% Save data
trainDataFile = GlobalSetting.TRAIN_DATA;
save(trainDataFile, 'trainData');
testDataFile = GlobalSetting.TEST_DATA;
save(testDataFile, 'testData');
