function [Beta] = backward_algorithm(PI,A,B,t,j)
% BACKWARD_ALGORITHM Summary of this function goes here
% 
% [OUTPUTARGS] = BACKWARD_ALGORITHM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/02 00:43:56 
% Revision: 0.1 

[M D]=size(B);  
N=length(PI);
beta(M,:)=1+zeros(1,N);
for x=M-1:-1:t
    for k=1:N            
      beta(x,k) = sum( (beta(x+1,:).*A(k,:) ) .* B(x+1,:)) ;                 
    end
end
Beta = beta(t,j);



end
