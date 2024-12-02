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

% The state of HMM model
N = 8;
% The dimension of continuous probability density function
D = 13;

% Model initialization and training
% Based on the instructions in the assignment, we can get initial A and Pi in Table 1
A_init = [0.8 0.2 0.0 0.0 0.0 0.0 0.0 0.0, 
          0.0 0.8 0.2 0.0 0.0 0.0 0.0 0.0, 
          0.0 0.0 0.8 0.2 0.0 0.0 0.0 0.0, 
          0.0 0.0 0.0 0.8 0.2 0.0 0.0 0.0, 
          0.0 0.0 0.0 0.0 0.8 0.2 0.0 0.0, 
          0.0 0.0 0.0 0.0 0.0 0.8 0.2 0.0, 
          0.0 0.0 0.0 0.0 0.0 0.0 0.8 0.2, 
          0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.8];
Pi_init = [1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0];
eta_init = [0 0 0 0 0 0 0 0.2]';
% Ntrain=size(trainData,2);

% for i=1:N
%     for j=1:Ntrain
%         data = trainData(:,j);
%         sampleData = data.sampleData;
%         sampleRate = data.sampleRate;
%         % Compute MFCC coefficients
%         mfccCoeff = mfccFeature(sampleData, sampleRate, D);
%         mfccCoeff=mfccCoeff';
% 
%         % Compute mean and variance
%         [meanData, varianceData] = meanVariance(mfccCoeff);
% 
%         % Compute transition probability
%         B = transitionProbability(mfccCoeff, meanData, varianceData, N);
% 
%     end
% end

[A_n,PII_n,U_X_n,VAR_X_n] = Baum_Welch_train(A_init, Pi_init, trainData, N, D);
disp(PII_n)


