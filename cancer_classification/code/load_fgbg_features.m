function fgbg = load_fgbg_features(img_ids, image_dir)
    [num_ids, ~] = size(img_ids);
    
    fgbg = zeros(num_ids, 76);
    
    for i = 1:num_ids
        mask_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        img_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_raw.tif');
        
        msk = logical(im2double(imread(mask_path)));
        img = rgb2gray(imread(img_path));
        
        props = region_props(img, msk);
        fg = transpose(histc(img(msk), 0:8:255));
        bg = transpose(histc(img(not(msk)), 0:8:255));
        
        fg = fg ./ sum(fg);
        bg = bg ./ sum(bg);
        
        fgbg(i,:) = [fg, bg, props];
    end
end

