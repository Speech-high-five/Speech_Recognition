%% Author: Zeyad Abdelmonem (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: za00632@surrey.ac.uk
%% Time: 30/11/2024 1:35

function [X_star, Q_star] = viterbi_algorithm(A, Pi_init, eta_init, B)
    
    %calculating number of states
    no_of_states = size(A, 2);

    %calculating T
    T_total = size(B, 2);
    
    %Initializing ln(deltas) and epsis
    ln_deltas = zeros(no_of_states, T_total);
    epsis = zeros(no_of_states, T_total);
    
    %initializing an array to store values of an expression
    values = zeros(no_of_states, T_total);

    %Initializing X*
    X_star = zeros(T_total, 1);

    %Initializing ln(deltas) and epsis at t=1
    for i = 1:no_of_states
        ln_deltas(i, 1) = log(Pi_init(i)) + log(B(i, 1));
        epsis(i, 1) = 0;
    end
    %Recursion
    for T = 2:T_total
        for j = 1:no_of_states
            for i = 1:no_of_states
                values(i) = ln_deltas(i, T - 1) + log(A(i, j));
            end
            [max_val, max_i] = max(values);
            ln_deltas(j, T) = max_val + log(B(j, T));
            epsis(j, T) = max_i;
        end
    end

    %initializing an array to store values of an expression
    values = zeros(no_of_states, 1);

    for i = 1:no_of_states
        values(i) = ln_deltas(i, T_total) + log(eta_init(i));
    end
    
    [max_val, max_i] = max(values);

    Q_star = max_val;
    X_star(T_total) = max_i;

    for T=T_total:2
        X_star(T-1) = epsi(X_star(T), T);
    end
    

end