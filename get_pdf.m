function [p] = get_pdf(m, v, x)
% GET_PDF Summary of this function goes here
% 
% [OUTPUTARGS] = GET_PDF(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/12/03 00:35:32 
% Revision: 0.1 

p = (2 * pi * prod(v)) ^ -0.5 * exp(-0.5 * (x-m) ./ v * (x-m)');

end
