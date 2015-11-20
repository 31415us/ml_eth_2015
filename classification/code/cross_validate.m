function mean_cv_error = cross_validate(classifiers, X, Y)
    part = cvpartition(Y, 'KFold', 10);
    
    f = @(Xtrain, Ytrain, Xtest, Ytest)(prediction_accuracy(Ytest, majority_voting(classifiers, Xtrain, Ytrain, Xtest)));
        
    mcr = crossval(f, X, Y, 'partition', part);
    
    mean_cv_error = mean(mcr);
end

