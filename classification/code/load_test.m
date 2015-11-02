function [T, Indices] = load_test(path, meanX, sX)
    M = csvread(path);
    Indices = M(:,1);
    % drop indices
    T = M(:,2:end);
    
    T = transform(T);
    
    [rows, ~] = size(T);
    
    T = T - ones(rows, 1) * meanX;
    T = T ./ (ones(rows, 1) * sX);
    
    %T = random_feature_projection(T);
end
