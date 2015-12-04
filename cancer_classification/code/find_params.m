function [params] = find_params(X, Y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    f = @(x) cv_svm_wrapper(x(1), x(2), X, Y);
    params = patternsearch(f, [1,1], [], [], [], [], [0.001, 0.001], [10, 100]);
    disp(f(params))
end

