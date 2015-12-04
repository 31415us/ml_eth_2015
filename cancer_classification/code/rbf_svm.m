function pred = rbf_svm(X, Y, T)

    params = find_params(X, Y);

    model = fitcsvm(X, Y, 'BoxConstraint', params(1), 'KernelFunction', 'rbf', 'KernelScale', params(2));

    pred = predict(model, T);
end
