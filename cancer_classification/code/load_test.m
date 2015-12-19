function [T, ix] = load_test(test_path, images_path)
    M = csvread(test_path);
    ix = M(:,1);
    
    PHOG_SIG = M(:,2:end);
    COLOR = load_color_features(ix, images_path);
    FCC = load_fcc_features(ix, images_path);
    LBP = load_lbp_features(ix, images_path);
    PROPS = load_region_props(ix, images_path);
    
    T = [PHOG_SIG, COLOR, FCC, LBP, PROPS];
end

