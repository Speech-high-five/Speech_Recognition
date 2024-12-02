%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 01/12/2024 23:28

clc;
close all;
clear;

% Define a function to make train and evaluation data
function [data] = make_data(datasetFolder)
% Define data structure
data = struct('name', {}, 'path', {}, 'word', {}, 'sampleData', {}, 'sampleRate', {}');
% Split dataset based on prefix data
allFiles = dir(fullfile([datasetFolder,'/*.mp3']));
filesLen = length(allFiles);
% Loop through all files to store them into data.
for i = 1:filesLen
    fileName = allFiles(i).name;
    fileNameSplited = split(fileName, "_");
    word = fileNameSplited{end};
    wordSplited = split(word, ".");
    word = wordSplited{1};
    filePath = [datasetFolder '/' fileName];
    [y,Fs]=audioread(filePath);

    % Store data into data
    data(end+1).name = fileName;
    data(end).path = filePath;
    data(end).word = word;
    data(end).sampleData = y;
    data(end).sampleRate = Fs;
end

end

% Get the train data and evaluation data
trainFolder = GlobalSetting.DATASET_FOLDER;
evaluationFolder = GlobalSetting.EVALUATION_FOLDER;

trainData = make_data(trainFolder);
evaluationData = make_data(evaluationFolder);

% Save the data to
trainDataFile = GlobalSetting.TRAIN_DATA;
save(trainDataFile, 'trainData');

evaluationFile = GlobalSetting.EVALUATION_DATA;
save(evaluationFile, 'evaluationData');
