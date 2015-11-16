function out = classifier(data_path, validation_path)
    [X, mX, sX, Y] = load_data(data_path);
    
    model = fitcecoc(X, Y, 'kfold', 10, 'Coding', 'ternarycomplete');
    
    cv_accuracy = classperf(model.kfoldPredict, Y);
    
    disp(cv_accuracy.CorrectRate);
    
    [T, ix] = load_test(validation_path, mX, sX);
    
    [rows, ~] = size(T);
    
    preds = zeros(rows, 10);
    
    for i = 1:10
        preds(:,i) = predict(model.Trained{i}, T);
    end
    
    most_pred = transpose(mode(transpose(preds)));
    
    out = [ix, most_pred];
end