function out = gp_regression(data_path, validation_path)
    [X, mX, sX, Y, mY, sY] = load_data(data_path);
    [T, indices] = load_test(validation_path, mX, sX);
    
    meanf = {@meanSum, {@meanConst, @meanLinear}};
    hyp.mean = zeros(6,1);
    covf = {@covSEiso};
    %covf = {@covGaboriso};
    hyp.cov = [log(1); log(1)];
    %hyp.cov = [1; 1];
    likf = @likGauss;
    hyp.lik = log(1.0);
    
    hyp = minimize(hyp, @gp, -1000, @infExact, meanf, covf, likf, X, Y);
    
    pred_mean = gp(hyp, @infExact, meanf, covf, likf, X, Y, T);
    
    pred = (sY * pred_mean) + mY;
    out = [indices pred];  
end