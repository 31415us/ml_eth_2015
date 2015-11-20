function pred = random_forest(X, Y, T)
    bagger = TreeBagger(100, X, Y, 'Method', 'Classification', 'NumPredictorsToSample', 'all');
    %disp(mean(bagger.oobError));
    pred = uint8(str2double(cell2mat(predict(bagger,T))));
end