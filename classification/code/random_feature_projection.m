function M = random_feature_projection(X)
    rng(4223246); % reseed for multiple calls

    outdim = 50;
    [rows, cols] = size(X);
    
    W = normrnd(0.0, 1.0, outdim, cols);
    b = 2 * pi * rand(outdim, 1);
    
    f = @(x) sqrt(2 / outdim) * cos((W * transpose(x)) + b);
    
    M = zeros(rows, outdim);
    
    for i = 1:rows
        M(i,:) = f(X(i,:));
    end
end