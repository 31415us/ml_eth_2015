function score = feature_selection_criterion(Xtrain, Ytrain, Xtest, Ytest)
    
    test_pred = rbf_svm(Xtrain, Ytrain, Xtest);
    
    [num_test, ~] = size(Ytest);
    
    score = sum(test_pred == Ytest) / num_test;
end

