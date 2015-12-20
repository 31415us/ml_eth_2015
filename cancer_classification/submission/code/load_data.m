function [X, Y] = load_data(train_path, image_prefix)
% LOAD_DATA load all the different features from the training set         

    M = csvread(train_path);
    train_ids = M(:,1);
    Y = M(:,end);
    
    % Get the PHOG features and 1D signature from the design matrix
    PHOG_SIG = M(:,2:end-1);
    
    % Get the foreground and background color mean from the images
    COLOR = load_color_features(train_ids, image_prefix);
    
    % Get Freeman Chain Code features of cell border
    FCC = load_fcc_features(train_ids, image_prefix);
    
    % local binary pattern features
    %LBP = load_lbp_features(train_ids, image_prefix);
    
    % features from matlabs regionprops function
    PROPS = load_region_props(train_ids, image_prefix);
    
    %X = [PHOG_SIG, COLOR, FCC, LBP, PROPS];
    X = [PHOG_SIG, COLOR, FCC, PROPS];
end

