function sims = n_min_max_kernel(U, V)
    [m, ~] = size(U);
    [n, ~] = size(V);
    sims = zeros(m, n);
    
    for i = 1:m
        for j = 1:n
            u = U(i,:);
            v = V(j,:);
            nu = u ./ sum(u);
            nv = v ./ sum(v);
            sims(i,j) = sum(min(nu, nv)) / sum(max(nu, nv));
        end
    end
end

