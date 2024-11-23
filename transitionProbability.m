function B = transitionProbability(mfccCoeff,meanData,varianceData)
% TRANSITIONPROBABILITY Summary of this function goes here
%
% [OUTPUTARGS] = TRANSITIONPROBABILITY(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/22 23:30:54
% Revision: 0.1

[D,M]=size(mfccCoeff);
[~,N]=size(meanData);
for j=1:N
    for t=1:M
        sumRes=sum(((mfccCoeff(:,t)-meanData(:,j))).^2./(2*varianceData(:,j)));
        productRes=(prod(varianceData(:,j)));
        B(j,t)=(exp(-sumRes)/((2*pi)^(D/2)*sqrt(productRes)));
    end
end
B=B';

end
