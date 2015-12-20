function score = feature_selection_criterion(Xtrain, Ytrain, Xtest, Ytest)
    forest = TreeBagger(100, Xtrain, Ytrain);
    
    test_pred = predict(forest, Xtest);
    
    test_pred = str2double(test_pred);
    
    score = - sum(test_pred == Ytest);
end

