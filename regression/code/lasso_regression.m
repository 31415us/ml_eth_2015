function [out] = lasso_regression(data_path, validation_path)
    id = @(x) x;
    inv = @(x) 1 ./ x;
    square = @(x) x ./ x;
    
    transforms = cell(1, 15);
    transforms(:) = {id};
    transforms{1} = inv;
    transforms{6} = inv;
    
    [X, mX, sX, Y, mY, sY] = load_data(data_path, transforms);
    
    [xrow, xcol] = size(X);
    
    % add squared columns
    for i = 1:xcol
        X = [X square(X(:,i))];
    end
    
    % 10 fold cross validated lasso
    [B, stats] = lasso(X, Y, 'CV', 10);
    
    disp(stats.MSE(stats.IndexMinMSE))
    
    best_beta = B(:, stats.IndexMinMSE);
    disp(best_beta(6))
    best_intercept = stats.Intercept(stats.IndexMinMSE);
    
    [T, Indices] = load_test(validation_path, mX, sX, transforms);
    
    % add squared columns
    for j = 1:xcol
        T = [T square(T(:,j))];
    end
    
    
    out = (T * best_beta) + best_intercept;
    out = (sY * out) + mY;
    
    out = [Indices out];
end