%% Author: Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: za00632@surrey.ac.uk
%% Time: 29/11/2024 02:39

function [A_new, B_new] = accumulate(alphas, betas, P, A_init, B, unique_words, counts)
    
    %calculating no of different words we have in our train data
    no_of_groups = size(unique_words,2);
    
    %calculating no of each different word in our train data
    no_of_words_per_group = counts(1);
    
    %calculating number of states
    no_of_states = size(A_init, 2);
    
    %calculating T
    T_total = size(B, 2);

    %initializing xi and gamma
    gamma = zeros(no_of_groups, no_of_words_per_group, no_of_states, T_total);
    xi = zeros(no_of_groups, no_of_words_per_group, no_of_states, no_of_states, T_total-1);

    %initializing X and Gamma
    X = zeros(no_of_states, no_of_states);
    Gamma = zeros(no_of_states, 1);
    
    %initializing M and V
    M = zeros(no_of_states, 1);
    V = zeros(no_of_states, 1);
    
    %initializing A and B
    A_new = zeros(size(A_init));
    B_new = zeros(size(B));

    for group = 1:no_of_groups
        for word = 1:no_of_words_per_group
            for T = 1:T_total - 1
                for i = 1:no_of_states
                    for j = 1:no_of_states
                        %Calculating xi from 1 to T_total - 1
                        xi(group, word, i, j, T) = alphas(group, word, i, T) * A_init(i, j) * B(j, T+1) * betas(group, word, j, T+1);
                    end
                end
            end
            %Dividing by probability of observations given model
            xi = xi / P(group, word);

            for T = 1:T_total
                for i = 1:no_of_states
                    %Calculating xi from 1 to T
                    gamma(group, word, i, T) = alphas(group, word, i, T) * betas(group, word, i, T);
                end
            end
            %Dividing by probability of observations given model
            gamma = gamma / P(group, word);

            for i = 1:no_of_states
                Gamma(i) = Gamma(i) + sum(squeeze(gamma(group, word, i, :)));
                M(i) = M(i) + sum(squeeze(gamma(group, word, i, :))* ___); %o_t_r
                V(i) = V(i) + sum(squeeze(Gamma))%how to do that expression
                for j = 1:no_of_states
                    X(i, j) = X(i, j) + sum(squeeze(xi(group, word, i, j, :)))
                end
            end
    
        end
    end

   %A
   %B

end