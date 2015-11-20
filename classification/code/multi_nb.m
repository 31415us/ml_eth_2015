function pred = multi_nb(X, Y, T)
%MULTICLASS NAIVE BAYES
%   
%   X     blabla
%   Y     blabla
%   T     Data to validate and test
%
%   pred  blabla

    distname = 'kernel';
    %distname = 'mn';
    %distname = 'mvmn';
    %distname = 'normal';

    %kernel = 'box';
    %kernel = 'epanechnikov';
    %kernel = 'normal';
    kernel = 'triangle';

    support = 'positive';
    %support = 'unbounded';

    if strcmp(distname, 'kernel')
        MNB = fitcnb(X, Y, 'DistributionNames', distname, 'Kernel', kernel, 'Support', support);
    else
        MNB = fitcnb(X, Y, 'DistributionNames', distname);
    end

    pred = predict(MNB, T);
    
end

