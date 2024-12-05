function plot_errors(epochs, errors)
% PLOT_ERRORS Summary of this function goes here
%
% [OUTPUTARGS] = PLOT_ERRORS(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/04 19:55:11
% Revision: 0.1

% Adjust the axes position for margins
figure('Position', [100 100 800 500], 'Visible', 'off');

% Get current axes
ax = gca;
% Position: [left, bottom, width, height]
ax.Position = [0.1, 0.1, 0.8, 0.8];

% Set the paper position mode
set(gcf, 'PaperPositionMode', 'auto');

% Set the font format of axis
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);

% Plot the amplitude spectrum of the original segment
plot(epochs, errors, "Color", "#8C92AC", 'LineWidth',2);

xlabel('Epoch');
ylabel('Error rate');

hold on;

% Plot the formant frequencies points
sz = 10;
scatter(epochs, errors, sz, "filled", "o", "MarkerFaceColor", "b");

titleStr = 'Error rate trend for the HMM model';
title(titleStr, 'FontSize', 12);

legend('Error rate curve', 'Error rate points');

% Set the scale
Xmin=1;
Xmax=16;
Ymin=0;
Ymax=1;

% Set maximum and minmum of X and Y
axis([Xmin,Xmax,Ymin,Ymax]);

% Set axis label 
set(gca,'XTick',(0.2:0.2:Xmax));
set(gca,'YTick',(Ymin:0.2:Ymax));
set(gca,'LooseInset',get(gca,'TightInset'));
box off;
hold off;

% Save graph
graphName = "Error_rate_trend_for_HMM_model";

saveDir = [GlobalSetting.GRAPH_PATH];
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end

savePath = [saveDir, '/', graphName, '.png'];
savePath = strjoin(savePath, '');

% Save the figure as a PNG file with specified margins
print(gcf, savePath, '-dpng', '-r300');  % '-r300' sets 300 DPI for high resolution


% Close the invisible figure
close(figure);

end
