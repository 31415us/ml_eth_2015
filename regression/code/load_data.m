function [X, meanX, stdX, Y, meanY, stdY] = load_data(input_path)
    M = csvread(input_path);
    % drop indices
    Y = M(:,end);
    M = M(:,2:end-1);
    
    X = transform(M);
    
    [rows, cols] = size(X);
    
    % normalize X
    meanX = mean(X, 1);
    stdX = std(X, 1);
    X = X - ones(rows, 1) * meanX;
    X = X ./ (ones(rows, 1) * stdX);
    
    % extract Y and and its mean/std
    meanY = mean(Y);
    stdY = std(Y);
    Y = (Y - meanY) ./ stdY;
    
end