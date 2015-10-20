function [out] = lasso_regression(data_path, validation_path)
    id = @(x) x;
    inv = @(x) 1 ./ x;
    
    transforms = cell(1, 15);
    transforms(:) = {id};
    transforms{1} = inv;
    
    [X, mX, sX, Y, mY, sY] = load_data(data_path, transforms);
    
    % 10 fold cross validated lasso
    [xrow, xcol] = size(X);
    X = [ones(xrow, 1) X];
    [B, stats] = lasso(X, Y, 'CV', 10);
    
    best_beta = B(:, stats.IndexMinMSE);
    
    [T, Indices] = load_test(validation_path, mX, sX, transforms);
    
    [trow, tcol] = size(T);
    T = [ones(trow, 1) T];
    
    out = T * best_beta;
    out = (sY * out) + mY;
    
    out = [Indices out];
end