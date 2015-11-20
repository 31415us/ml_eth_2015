function pred = transformation_svm(X, Y, T)
    
    X = transform(X);
    T = transform(T);

    wake_or_rem = Y == 0 | Y == 1;
    wake_or_nrem = Y == 0 | Y == 2;
    rem_or_nrem = Y == 1 | Y == 2;

    learners = cell(1,3);
    learners{1} = templateSVM('BoxConstraint', 1, 'KernelFunction', 'linear', 'KernelScale', 1);
    learners{2} = templateSVM('BoxConstraint', 1, 'KernelFunction', 'linear', 'KernelScale', 1);
    learners{3} = templateSVM('BoxConstraint', 1, 'KernelFunction', 'linear', 'KernelScale', 1);

    coding = [1, 1, 0; -1, 0, 1; 0, -1,  -1];

    model = fitcecoc(X, Y, 'Coding', coding, 'Learners', learners);

    pred = predict(model, T);
end
