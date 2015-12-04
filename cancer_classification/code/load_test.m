function [T, ix] = load_test(test_path, images_path)
    M = csvread(test_path);
    ix = M(:,1);
    
    PHOG_SIG = M(:,2:end);
    FG_BG = load_fgbg_features(ix, images_path);
    
    T = [PHOG_SIG, FG_BG];
end

