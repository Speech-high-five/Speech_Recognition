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
Ntrain=size(trainData,2);

%Flag to solve underflow or not
solveUnderflow = true;

% Sorting training data to have each word files next to each other to ease
% training
[trainData, unique_words, counts] = sortByWords(trainData);

% for i=1:N
%     for j=1:Ntrain
%         data = trainData(:,j);
%         sampleData = data.sampleData;
%         sampleRate = data.sampleRate;
%         % Compute MFCC coefficients
%         mfccCoeff = mfccFeature(sampleData, sampleRate, D);
%         mfccCoeff=mfccCoeff';

%         % Compute mean and variance
%         [meanData, varianceData] = meanVariance(mfccCoeff);

%         % Compute transition probability
%         B = transitionProbability(mfccCoeff, meanData, varianceData, N);
        
%     end
% end

% %Running forward algorithm
% [alphas, P_forward, scale_factors] = forward_algorithm(A_init, Pi_init, eta_init, B, unique_words, counts, solveUnderflow);

% %Running backward algorithm
% [betas, P_backward] = backward_algorithm(A_init, Pi_init, eta_init, B, unique_words, counts, solveUnderflow, scale_factors);

% %Accumlating occupation and transition liklihoods and reestimation of A, B
% [A_new, B_new] = accumulate(alphas, betas, P_forward, A_init, B, unique_words, counts);

% [X_star, Q_star] = viterbi_algorithm(A_init, Pi_init, eta_init, B);


%calculating no of different words we have in our train data
no_of_groups = size(unique_words,2);

%calculating no of each different word in our train data
no_of_words_per_group = counts(1);

%calculating number of states
no_of_states = N;

%calculating T
T_total = N;

%Initializing alphas matrix and Probability matrix
alphas = zeros(no_of_groups, no_of_words_per_group, no_of_states, T_total);
P_forward = zeros(no_of_groups, no_of_words_per_group);

%Initializing scale factor
scale_factors = ones(T_total, 1);

wordData = {trainData.word};
sampleDataset = {trainData.sampleData};
sampleRateData = {trainData.sampleRate};


for group = 1:no_of_groups
  word = unique_words(group);
  % Find the index of the current gender and segment length
  idxes = find(strcmp(wordData, word));
  wordList = wordData(idxes);
  sampleDataList = sampleDataset(idxes);
  sampleRateList = sampleRateData(idxes);
  for word = 1:no_of_words_per_group
    sampleData = cell2mat(sampleDataList(word));
    sampleRate = cell2mat(sampleRateList(word));
    % Compute MFCC coefficients
    mfccCoeff = mfccFeature(sampleData, sampleRate, D);
    mfccCoeff=mfccCoeff';

    % Compute mean and variance
    [meanData, varianceData] = meanVariance(mfccCoeff);

    % Compute transition probability
    B = transitionProbability(mfccCoeff, meanData, varianceData, N);
      %Initialize the first time step
      for state_order = 1:no_of_states
          alphas(group, word, state_order, 1) = Pi_init(state_order) * B(state_order, 1);
      end

      if solveUnderflow
          scale_factors(1) = 1/sum(alphas(group, word, :, 1));
          alphas(group, word, :, 1) = scale_factors(1) * alphas(group, word, :, 1);
      end

      %Recursion
      for T = 2:T_total
          for j = 1:no_of_states
              sum_ = 0;
              for i = 1:no_of_states
              sum_ = sum_ + alphas(group, word, i, T-1) * A_init(i,j);
              end
              alphas(group, word, j, T) = sum_ * B(j,T);
          end

          if solveUnderflow
              scale_factors(T) = 1 / sum(alphas(group, word, :, T));
              alphas(group, word, :, T) = scale_factors(T) * alphas(group, word, :, T);
          end
      end
      P_forward(group, word) = sum(squeeze(alphas(group, word, :, T_total)) .* eta_init);
  end
end



