function [X, Y] = load_data(train_path, image_prefix)
% LOAD_DATA load all the different features from the training set         

    M = csvread(train_path);
    train_ids = M(:,1);
    Y = M(:,end);
    
    % Get the PHOG features and 1D signature from the design matrix
    PHOG_SIG = M(:,2:end-1);
    
    % Get the foreground and background color mean from the images
    FG_BG = load_fgbg_features(train_ids, image_prefix);
    
    FCC = load_fcc_features(train_ids, image_prefix);
    
    LBP = load_lbp_features(train_ids, image_prefix);
    
    X = [PHOG_SIG, FG_BG, FCC, LBP];
end

