function [A_n,PII_n,U_X_n,VAR_X_n] = Baum_Welch_train(A_init, PII_init, Train_data, N, D)
% BAUM_WELCH_TRAIN Summary of this function goes here
%
% [OUTPUTARGS] = BAUM_WELCH_TRAIN(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/12/02 00:40:28
% Revision: 0.1

L=size(Train_data,2);

%%%%%%%%%%%%% PII training %%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for h=1:L
        data = Train_data(:,h);
        sampleData = data.sampleData;
        sampleRate = data.sampleRate;
        % Compute MFCC coefficients
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        x=mfccCoeff';

        [ u_x,var_x ] = meanVariance( x,N );
        B = transitionProbability( x,u_x,var_x );
        G(h)=gama_algorithm(PII_init,A_init,B,1,i);
    end
    PII_n(i)=sum(G)/L;
end
%%%%%%%%%%%%%% A training %%%%%%%%%%%%%%%%%%%
G=0; Z=0;
for i=1:N
    for j=1:N
        for h=1:L
            data = Train_data(:,h);
            sampleData = data.sampleData;
            sampleRate = data.sampleRate;
            % Compute MFCC coefficients
            mfccCoeff = mfccFeature(sampleData, sampleRate, D);
            x=mfccCoeff';

            [ u_x,var_x ] = meanVariance( x,N );
            B = transitionProbability( x,u_x,var_x );
            [I,T]=size(x);
            for t=1:T-1
                Z=Z+zeta_algorithm(PII_n,A_init,B,t,i,j);
                G=G+gama_algorithm(PII_n,A_init,B,t,i  );
            end
        end
        A_n(i,j)=Z/G;
        Z=0;G=0;
    end
end
%%%%%%%%%%%%%% U training %%%%%%%%%%%%%%%%%%%%
G=zeros(D,1);Z=0;
for j=1:N
    for h=1:L
        data = Train_data(:,h);
        sampleData = data.sampleData;
        sampleRate = data.sampleRate;
        % Compute MFCC coefficients
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        x=mfccCoeff';

        [ u_x,var_x ] = meanVariance( x,N );
        B = transitionProbability( x,u_x,var_x );
        for t=1:T
            G=G+(  gama_algorithm( PII_n,A_n,B,t,j )*x(:,t) );
            Z=Z+   gama_algorithm( PII_n,A_n,B,t,j );
        end
    end
    U_X_n(:, j ) =G / Z;
    G=zeros(D,1);Z=0;
end

%%%%%%%%%%%%%%%%%% VAR Training %%%%%%%%%%%%%%%%%%%
G=zeros(D,D);Z=0;
for j=1:N
    for h=1:L
        data = Train_data(:,h);
        sampleData = data.sampleData;
        sampleRate = data.sampleRate;
        % Compute MFCC coefficients
        mfccCoeff = mfccFeature(sampleData, sampleRate, D);
        x=mfccCoeff';

        [ u_x,var_x ] = meanVariance( x,N );
        B = transitionProbability( x,u_x,var_x );
        [I,T]=size(x);
        for t=1:T
            G=G+(gama_algorithm(PII_n,A_n,B,t,j)*(((x(:,t)-U_X_n(:,j)))*(x(:,t)-U_X_n(:,j))'));
            Z=Z +gama_algorithm(PII_n,A_n,B,t,j );
        end
    end
    VAR_X_n(:,j)= diag(G) / Z;
    G=zeros(D,D);Z=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end
