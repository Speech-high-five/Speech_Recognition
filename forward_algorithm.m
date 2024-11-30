%% Author: Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: za00632@surrey.ac.uk
%% Time: 29/11/2024 00:36

function [alphas, P_forward, scale_factors] = forward_algorithm(A_init, Pi_init, eta_init, B, unique_words, counts, solveUnderflow)

    %calculating no of different words we have in our train data
    no_of_groups = size(unique_words,2);
    
    %calculating no of each different word in our train data
    no_of_words_per_group = counts(1);
    
    %calculating number of states
    no_of_states = size(A_init, 2);
    
    %calculating T
    T_total = size(B, 2);
    
    %Initializing alphas matrix and Probability matrix
    alphas = zeros(no_of_groups, no_of_words_per_group, no_of_states, T_total);
    P_forward = zeros(no_of_groups, no_of_words_per_group);

    %Initializing scale factor
    scale_factors = ones(T_total, 1);
    
    for group = 1:no_of_groups
        for word = 1:no_of_words_per_group
            %Initialize the first time step
            for state_order = 1:no_of_states
                alphas(group, word, state_order, 1) = Pi_init(state_order) * B(state_order, 1);
            end

            if solveUnderflow
                scale_factors(1) = 1/sum(alphas(group, word, :, 1));
                alphas(group, word, :, 1) = scale_factors(1) * alphas(group, word, :, 1);
            end

            %Recursion
            for T = 2:T_total
                for j = 1:no_of_states
                    sum_ = 0;
                    for i = 1:no_of_states
                    sum_ = sum_ + alphas(group, word, i, T-1) * A_init(i,j);
                    end
                    alphas(group, word, j, T) = sum_ * B(j,T);
                end

                if solveUnderflow
                    scale_factors(T) = 1 / sum(alphas(group, word, :, T));
                    alphas(group, word, :, T) = scale_factors(T) * alphas(group, word, :, T);
                end
            end
            P_forward(group, word) = sum(squeeze(alphas(group, word, :, T_total)) .* eta_init);
        end
    end
end