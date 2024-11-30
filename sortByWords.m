%% Author: Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: za00632@surrey.ac.uk
%% Time: 28/11/2024 18:41

%function to sort training data by words, as to have similar words
%following each other, this is done by sorting alphabetically

function [output_trainData, unique_words, word_counts] = sortByWords(trainData)

    table = struct2table(trainData);
    sorted_table = sortrows(table, 'word');
    output_trainData = table2struct(sorted_table)';

    all_words = {trainData.word};

    % Get unique words and their counts
    [unique_words, ~, idx] = unique(all_words);
    word_counts = accumarray(idx, 1);
    
end