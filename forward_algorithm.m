function [ALFA] = forward_algorithm(PI,A,B,t,j)
% FORWARD_ALGORITHM Summary of this function goes here
% 
% [OUTPUTARGS] = FORWARD_ALGORITHM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/02 00:43:03 
% Revision: 0.1 

N=length(PI);
alfa(1,:)=PI.*B(1,:);
for x=2:t
    for k=1:N            
      alfa(x,k) = sum(alfa(x-1,:).*(A(:,k))') * B(x,k) ;                 
    end
end
ALFA = alfa(t,j);


end
