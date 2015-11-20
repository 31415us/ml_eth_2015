function [W, b] = rff_params(in_dim, out_dim)
    W = random('normal', 0, 1, in_dim, out_dim);
    b = random('unif', 0, 1, 1, out_dim);
end

