function [X, Y] = load_data(train_path, image_prefix)
    M = csvread(train_path);
    train_ids = M(:,1);
    Y = M(:,end);
    PHOG_SIG = M(:,2:end-1);
    FG_BG = load_fgbg_features(train_ids, image_prefix);
    
    X = [PHOG_SIG, FG_BG];
end

