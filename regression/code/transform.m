function M = transform(X)
    
    reduced = [(1 ./ X(:,1)) X(:,2) X(:,4) (1 ./ X(:,6)) X(:,14)];
    
    %M = reduced;
    
    for i = 1:5
        for j = i:5
            reduced = [reduced (reduced(:,i) .* reduced(:,j))];
        end
    end
    
    for i = 1:5
        reduced = [reduced X(:,i).^3];
    end
    
    M = reduced;
    
    %M = [X(:,1) X(:,2) X(:,4) X(:,6) X(:,14)];
end