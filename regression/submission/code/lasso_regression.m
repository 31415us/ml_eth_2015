function [out] = lasso_regression(data_path, validation_path)
    
    [X, mX, sX, Y, mY, sY] = load_data(data_path);
    
    % 10 fold cross validated lasso
    [B, stats] = lasso(X, Y, 'CV', 10);
    
    disp(stats.MSE(stats.IndexMinMSE))
    
    best_beta = B(:, stats.IndexMinMSE);
    
    %lassoPlot(B, stats, 'PlotType', 'CV');
    
    %disp(best_beta)
    best_intercept = stats.Intercept(stats.IndexMinMSE);
    
    [T, Indices] = load_test(validation_path, mX, sX);  
    
    out = (T * best_beta) + best_intercept;
    out = (sY * out) + mY;
    
    out = [Indices out];
end