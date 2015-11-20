function pred = majority_voting(classifiers, X, Y, T)
    num_classifiers = size(classifiers,2);
    num_predictions = size(T,1);
    
    votes = zeros(num_predictions, num_classifiers);
    for i = 1:num_classifiers
        classifier = classifiers{i};
        p = classifier(X,Y,T);
        votes(:,i) = p;
    end
    
    pred = mode(votes, 2);
end

