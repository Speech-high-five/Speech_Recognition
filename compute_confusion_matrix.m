%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 03/12/2024 22:19

clc;
close all;
clear;

% Load recognition result
evaluationDataFile = GlobalSetting.RECOGNITION_RESULT;
evaluationData = load(evaluationDataFile, 'evaluationData').evaluationData;


true_word = {evaluationData.word};
prediction = {evaluationData.prediction};

% Plot the confusion matrix
fig = figure;
cm = confusionchart(true_word,prediction, 'RowSummary','row-normalized','ColumnSummary','column-normalized');
cm.Title = 'Confusion Matrix for Speech Recognition Result';

fig_Position = fig.Position;
fig_Position(3) = fig_Position(3)*1.5;
fig.Position = fig_Position;

% Save the graph as a high-resolution PNG file
saveDir = GlobalSetting.GRAPH_PATH;
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end
savePath=[saveDir, '/confusion_matrix.png'];

% exportgraphics(fig, savePath, 'Resolution', 300);
% Save the figure as a PNG file with specified margins
print(gcf, savePath, '-dpng', '-r300');  % '-r300' sets 300 DPI for high resolution
