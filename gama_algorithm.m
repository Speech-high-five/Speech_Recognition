function [GAMA] = gama_algorithm(PI,A,B,t,i)
% GAMA_ALGORITHM Summary of this function goes here
% 
% [OUTPUTARGS] = GAMA_ALGORITHM(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/02 00:41:53 
% Revision: 0.1 

N=length(PI);
alfa=forward_algorithm(PI,A,B,t,i);
beta=backward_algorithm(PI,A,B,t,i);

Ptot = 0;
for m=1:N
Ptot= Ptot + (forward_algorithm(PI,A,B,t,m)*backward_algorithm(PI,A,B,t,m));
end
GAMA=alfa*beta/Ptot;



end
