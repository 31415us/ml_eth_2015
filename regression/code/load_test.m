function [T, Indices] = load_test(path, meanX, sX, transforms)
    M = csvread(path);
    Indices = M(:,1);
    % drop indices
    M = M(:,2:end);
    
    [rows, cols] = size(M);
    
    T = [];
    
    for i = 1:cols
        T = [T transforms{i}(M(:, i))];
    end
    
    [rows, cols] = size(T);
    
    T = T - ones(rows, 1) * meanX;
    T = T ./ (ones(rows, 1) * sX);
end
