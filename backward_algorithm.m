%% Author: Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: za00632@surrey.ac.uk
%% Time: 29/11/2024 02:01

function [betas, P_backward] = backward_algorithm(A_init, Pi_init,eta_init, B, unique_words, counts, solveUnderflow, scale_factors)
    
    %calculating no of different words we have in our train data
    no_of_groups = size(unique_words,2);
    
    %calculating no of each different word in our train data
    no_of_words_per_group = counts(1);
    
    %calculating number of states
    no_of_states = size(A_init, 2);
    
    %calculating T
    T_total = size(B, 2);
    
    %Initializing alphas matrix and Probability matrix
    betas = zeros(no_of_groups, no_of_words_per_group, no_of_states, T_total);
    P_backward = zeros(no_of_groups, no_of_words_per_group);
    
    for group = 1:no_of_groups
        for word = 1:no_of_words_per_group
            %Initialization
            for state_order = 1:no_of_states
                betas(group, word, state_order,T_total) = eta_init(state_order);
            end

            if solveUnderflow
                betas(group, word, :, T_total) = scale_factors(T_total) * betas(group, word, :,T_total);
            end

            %Recursion
            for T = T_total - 1:-1:1
                for i = 1:no_of_states
                    sum_ = 0;
                    for j = 1:no_of_states
                        sum_ = sum_ + A_init(i,j) * B(j, T+1) * betas(group, word, j, T+1);
                    end
                    betas(group, word, i, T) = sum_;
                end

                if solveUnderflow
                    betas(group, word, :, T) = scale_factors(T) * betas(group, word, :,T);
                end
            end
            sum_prob = 0;
            for i = 1:no_of_states
                sum_prob = sum_prob + Pi_init(i) * B(i,1) * betas(group, word, i, 1);
            end
            P_backward(group, word) = sum_prob;
        end
    end


end
