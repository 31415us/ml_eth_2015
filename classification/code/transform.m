function M = transform(X)
    [n_samples, n_dim] = size(X);
    squared_terms = [];
    for i = 1:n_dim
        for j = i:n_dim
            squared_terms = [squared_terms X(:,i) .* X(:,j)];
        end
    end
    
    M = [X, squared_terms];
    M = [M, log(100 + M)];
end