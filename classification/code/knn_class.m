function pred = knn_class(X, Y, T)
%KNN CLASSIFICATION
%  
%   X     Variables
%   Y     Predictors
%   T     Datas to validate and test
%
%   pred  Predicates

    NUM_OF_NEIGHBOURS = 15;

    mdl = fitcknn(X,Y,'NumNeighbors',NUM_OF_NEIGHBOURS);
    
    % DEBUG
%     cvmdl = crossval(mdl);
%     kloss = kfoldLoss(cvmdl);
%     disp(kloss);
    
    pred = predict(mdl,T);


end

