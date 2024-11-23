function B = transitionProbability(mfccCoeff, meanData, varianceData)
  % TRANSITIONPROBABILITY Calculate the transition probability matrix.
  %
  % B = TRANSITIONPROBABILITY(MFCCCOEFF, MEANDATA, VARIANCEDATA) computes the
  % transition probability matrix B, where each element B(j,t) represents the
  % probability of transitioning from state j to observation t. The input
  % MFCCCOEFF is a matrix of MFCC coefficients with dimensions D x M, where D
  % is the number of MFCC coefficients and M is the number of observations.
  % MEANDATA and VARIANCEDATA are matrices of mean and variance values, each
  % with dimensions D x N, where N is the number of states.
  %
  % Examples:
  %   mfccCoeff = rand(13, 100); % Example MFCC coefficients matrix (13 coefficients, 100 observations)
  %   meanData = rand(13, 5);    % Example mean data matrix (13 coefficients, 5 states)
  %   varianceData = rand(13, 5); % Example variance data matrix (13 coefficients, 5 states)
  %   B = transitionProbability(mfccCoeff, meanData, varianceData);
  %   disp(B);
  %
  % See also: meanVariance, featureExtraction
  
  % Author: Xiaoguang Liang, University of Surrey
  % Date: 2024/11/22 23:30:54
  % Revision: 0.1
  
  % Get the dimensions of the input matrices
  [D, M] = size(mfccCoeff);  % D: number of MFCC coefficients, M: number of observations
  [~, N] = size(meanData);   % N: number of states
  
  % Initialize the transition probability matrix B
  B = zeros(N, M);
  
  % Loop through each state and each observation to calculate the transition probability
  for j = 1:N
      for t = 1:M
          % Calculate the sum of squared differences divided by twice the variance
          sumRes = sum(((mfccCoeff(:, t) - meanData(:, j)).^2) ./ (2 * varianceData(:, j)));
          
          % Calculate the product of the variance values
          productRes = prod(varianceData(:, j));
          
          % Compute the transition probability using the Gaussian distribution formula
          B(j, t) = (exp(-sumRes) / ((2 * pi)^(D / 2) * sqrt(productRes)));
      end
  end
  
  % Transpose the matrix B to match the desired output format
  B = B';
  
  end