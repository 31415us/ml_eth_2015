function [R] = rff_transform(X, W, b)
    [num_samples, ~] = size(X);
    R = X*W + ones(num_samples, 1) * b;
end

