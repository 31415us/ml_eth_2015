function [X, meanX, stdX, Y, meanY, stdY] = load_data(input_path, transforms)
    M = csvread(input_path);
    % drop indices
    M = M(:,2:end);
    
    [rows, cols] = size(M);
    
    X = [];
    
    for i = 1:cols
        X = [X transforms{i}(M(:,i))];
    end
    
    [rows, cols] = size(X);
    
    % normalize X
    meanX = mean(X, 1);
    stdX = std(X, 1);
    X = X - ones(rows, 1) * meanX;
    X = X ./ (ones(rows, 1) * stdX);
    
    % extract Y and and its mean/std
    Y = X(:,end);
    meanY = meanX(:,end);
    stdY = stdX(:,end);
    
    % drop Y from X
    X = X(:,1:end-1);
    meanX = meanX(:,1:end-1);
    stdX = stdX(:,1:end-1);
end