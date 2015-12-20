function [T, ix] = load_test(test_path, images_path)

    M = csvread(test_path);
    ix = M(:,1);
    
    % Get the PHOG features and 1D signature from the design matrix
    PHOG_SIG = M(:,2:end);

    % Get the foreground and background color mean from the images
    COLOR = load_color_features(ix, images_path);

    % Get Freeman Chain Code features of cell border
    FCC = load_fcc_features(ix, images_path);

    % local binary pattern features
    %LBP = load_lbp_features(ix, images_path);

    % features from matlabs regionprops function
    PROPS = load_region_props(ix, images_path);
    
    %T = [PHOG_SIG, COLOR, FCC, LBP, PROPS];
    T = [PHOG_SIG, COLOR, FCC, PROPS];
end

