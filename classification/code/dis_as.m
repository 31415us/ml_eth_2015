function pred = dis_as(X, Y, T)
%DISCRIMINANT_ANALYSIS Performs discriminant analysis
%   
%   X     blabla
%   Y     blabla
%   T     Data to validate and test
%
%   pred  blabla

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

