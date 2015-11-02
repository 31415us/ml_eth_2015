function [Xwake, Xrem, Xnrem, meanX, stdX] = load_data(input_path)
    M = csvread(input_path);
    % drop indices
    Y = M(:,end);
    M = M(:,2:end-1);
    
    X = transform(M);
    
    [rows, ~] = size(X);
    
    % normalize X
    meanX = mean(X, 1);
    stdX = std(X, 1);
    X = X - ones(rows, 1) * meanX;
    X = X ./ (ones(rows, 1) * stdX);
    
    wakeIndices = Y == 0;
    remIndices = Y == 1;
    nremIndices = Y == 2;
    
    Xwake = X(wakeIndices,:);
    Xrem = X(remIndices,:);
    Xnrem = X(nremIndices,:);
end