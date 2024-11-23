function mfccCoeff = mfccFeature(sampleData, sampleRate, Dimension)
% MFCCFEATURE Summary of this function goes here
% 
% [OUTPUTARGS] = MFCCFEATURE(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/22 23:26:20 
% Revision: 0.1 


% PARAMETERS
frame_length_ms = 30;   % Frame length in ms
hop_size_ms = 10;       % Hop size in ms

% Frame size and hop size in samples
frame_length_samples = round(frame_length_ms / 1000 * sampleRate);  % Convert ms to samples
hop_size_samples = round(hop_size_ms / 1000 * sampleRate);        % Convert ms to samples

% Define a function for extracting MFCCs from a windowed frame
extract_mfcc_from_frame = @(audio, fs, frame_length, hop_size, num_coeffs) ...
    mfcc(audio, fs, 'Window', hamming(frame_length, 'periodic'), ...
         'OverlapLength', frame_length - hop_size, 'NumCoeffs', num_coeffs, 'LogEnergy', 'replace');

% Extract MFCCs for each audio file using frame-based processing
mfccCoeff = extract_mfcc_from_frame(sampleData, sampleRate, frame_length_samples, hop_size_samples, Dimension);

end
