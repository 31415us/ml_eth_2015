function [X, meanX, stdX, labels] = load_data(input_path)
    M = csvread(input_path);
    % drop indices
    labels = uint8(M(:,end));
    X = M(:,2:end-1);
    
    X = transform(X);
    
    [rows, ~] = size(X);
    
    % normalize X
    meanX = mean(X, 1);
    stdX = std(X, 1);
    X = X - ones(rows, 1) * meanX;
    X = X ./ (ones(rows, 1) * stdX);
end