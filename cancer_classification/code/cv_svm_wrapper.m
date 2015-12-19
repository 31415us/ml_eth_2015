function [cv_error] = cv_svm_wrapper(C, sigma, X, Y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    model = fitcsvm(X, Y, 'BoxConstraint', C, 'KernelFunction', 'rbf', 'KernelScale', sigma, 'KFold', 10, 'CacheSize', 'maximal');
    cv_error = model.kfoldLoss;
end

