function pred = d_tree(X, Y, T)
%DECISION TREE
%   
%   X     Variables
%   Y     Predictors
%   T     Datas to validate and test
%
%   pred  Predicates

    algorithm = 'Exact';
    %algorithm = 'PullLeft';
    %algorithm = 'PCA';
    %algorithm = 'OVAbyClass';

    maxnumcat = 10;
    
    maxnumsplit = 30;
    %maxnumsplit = size(X_prep,1)-1;
    %maxnumsplit = 200;

    % Take care of split criteria

    mergeleaves = 'on';
    %mergeleaves = 'off';

    minleaf = 1;
    minparent = 10;

    numvariables = 'all';
    %numvariables = 10;

    %prunes = 'on';
    prunes = 'off';

    prunec = 'error';
    %prunec = 'impurity';
    
    splitcr = 'gdi';


    DT = fitctree(X, Y, 'AlgorithmForCategorical', algorithm, 'SplitCriterion', splitcr, 'MaxNumCategories', maxnumcat, 'MaxNumSplits', maxnumsplit, 'MergeLeaves', mergeleaves, 'MinLeafSize', minleaf, 'MinParentSize', minparent, 'NumVariablesToSample', numvariables, 'Prune', prunes, 'PruneCriterion', prunec);

    %view(DT,'mode','graph');
    DecT = prune(DT, 'Level', 8);
    %DecT = prune(DT, 'Alpha', 0.03);
    %DecT = prune(DT, 'Nodes', [1 2 3 4]);

    %view(DecT,'mode','graph');

    pred = predict(DecT, T);

end

