function pred = dis_as(X, Y, T)
%DISCRIMINANT ANALYSIS
%   
%   X     Variables
%   Y     Predictors
%   T     Datas to validate and test
%
%   pred  Predicates

    discrimType = 'linear';
    %discrimType = 'quadratic';
    %discrimType = 'diagLinear';
    %discrimType = 'diagQuadratic';
    %discrimType = 'pseudoLinear';
    %discrimType = 'pseudoQuadratic';

    delta = 1;

    LDA = fitcdiscr(X, Y, 'DiscrimType', discrimType, 'Delta', delta);

    pred = predict(LDA, T);
    
end

