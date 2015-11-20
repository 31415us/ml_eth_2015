function pred = rbf_svm(X, Y, T)

    wake_or_rem = Y == 0 | Y == 1;
    wake_or_nrem = Y == 0 | Y == 2;
    rem_or_nrem = Y == 1 | Y == 2;

    wake_rem_params = find_params(X(wake_or_rem, :), Y(wake_or_rem));
    wake_nrem_params = find_params(X(wake_or_nrem, :), Y(wake_or_nrem));
    rem_nrem_params = find_params(X(rem_or_nrem, :), Y(rem_or_nrem));

    learners = cell(1,3);
    learners{1} = templateSVM('BoxConstraint', wake_rem_params(1), 'KernelFunction', 'rbf', 'KernelScale', wake_rem_params(2));
    learners{2} = templateSVM('BoxConstraint', wake_nrem_params(1), 'KernelFunction', 'rbf', 'KernelScale', wake_nrem_params(2));
    learners{3} = templateSVM('BoxConstraint', rem_nrem_params(1), 'KernelFunction', 'rbf', 'KernelScale', rem_nrem_params(2));

    coding = [1, 1, 0; -1, 0, 1; 0, -1,  -1];

    model = fitcecoc(X, Y, 'Coding', coding, 'Learners', learners);

    pred = predict(model, T);
end
