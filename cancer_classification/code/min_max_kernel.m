function sims = min_max_kernel(U, V)
    [m, ~] = size(U);
    [n, ~] = size(V);
    sims = zeros(m, n);
    
    for i = 1:m
        for j = 1:n
            u = U(i,:);
            v = V(j,:);
            sims(i,j) = sum(min(u,v)) / sum(max(u,v));
        end
    end
end

