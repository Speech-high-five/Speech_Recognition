%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/11/2024 22:52

clc;
close all;
clear;
[heed, fs_heed] = audioread('sp01a_w01_heed.mp3'); 

mfcc = mfccFeature(heed, fs_heed, 13);
