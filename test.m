%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/11/2024 23:05

clc;
close all;
clear;

% Load test data
testDataFile = GlobalSetting.TEST_DATA;
load(testDataFile, 'testData');

testData = testData.sampleData;
testDataLen = length(testData);
testData = cell2mat(testData);
