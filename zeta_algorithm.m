function [ZETA] = zeta_algorithm(PI,A,B,t,i,j)
% ZETA_ALGORITHM Summary of this function goes here
% 
% [OUTPUTARGS] = ZETA_ALGORITHM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/02 00:45:01 
% Revision: 0.1 

N=length(PI);
num=forward_algorithm(PI,A,B,t,i)*A(i,j)*B(t+1,j)*backward_algorithm(PI,A,B,t+1,j);
Ptot=0;
for m=1:N
Ptot= Ptot + (forward_algorithm(PI,A,B,t,m)*backward_algorithm(PI,A,B,t,m));
end
ZETA=num/Ptot;



end
