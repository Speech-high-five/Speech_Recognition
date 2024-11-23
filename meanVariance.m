function [meanData, varianceData] = meanVariance(mfccCoeff)
% MEANVARIANCE Summary of this function goes here
%
% [OUTPUTARGS] = MEANVARIANCE(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/22 23:28:41
% Revision: 0.1

[D,M]=size(mfccCoeff);  % M : num of observations
meanData=zeros(D,D);
varianceData=zeros(D,D);
k=floor(M/D);
for i=1:D-1
    meanData(:,i)= mean(mfccCoeff(:,k*(i-1)+1:i*k)')';
    varianceData(:,i)=  var(mfccCoeff(:,k*(i-1)+1:i*k)')';
end
i=D;
meanData(:,i)= mean(mfccCoeff(:,k*(i-1)+1:end)' )';
varianceData(:,i)= var(mfccCoeff(:,k*(i-1)+1:end)' )';

% meanData = mean(mfccCoeff')';
% varianceData =  var(mfccCoeff')';
% varianceData = diag(varianceData);
end

