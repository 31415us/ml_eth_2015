function pred = random_forest(X, Y, T)
    bagger = TreeBagger(1000, X, Y, 'OOBPrediction', 'on', 'Method', 'Classification', 'NumPredictorsToSample', 'all');
    disp(mean(bagger.oobError));
    pred = uint8(str2double(cell2mat(predict(bagger,T))));
end