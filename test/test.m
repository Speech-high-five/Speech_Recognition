%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 03/12/2024 08:17

clc;
close all;
clear;

% 2D cell array
C = {'Alice', 25; 'Bob', 30};

% Field names
fieldnames = {'Name', 'Age'};

% Convert cell array to struct
S = cell2struct(C', fieldnames, 1);

% Display the struct
disp(S);