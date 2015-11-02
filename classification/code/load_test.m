function [T, Indices] = load_test(path, meanX, sX)
    M = csvread(path);
    Indices = M(:,1);
    % drop indices
    M = M(:,2:end);
    
    T = transform(M);
    
    [rows, ~] = size(T);
    
    T = T - ones(rows, 1) * meanX;
    T = T ./ (ones(rows, 1) * sX);
end
