function M = transform(X)
    
    reduced = [(1 ./ X(:,1)) X(:,2) X(:,4) (1 ./ X(:,6)) X(:,14)];
    
    for i = 1:5
        for j = i:5
            reduced = [reduced (reduced(:,i) .* reduced(:,j))];
        end
    end
    
    M = reduced;
end