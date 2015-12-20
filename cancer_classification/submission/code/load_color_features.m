function color_features = load_color_features(img_ids, image_dir)
    [num_ids, ~] = size(img_ids);

    color_features = zeros(num_ids, 192);
    
    for i = 1:num_ids
        mask_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        img_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_raw.tif');
        
        msk = logical(im2double(imread(mask_path)));
        color = imread(img_path);
        gray = rgb2gray(color);

        % color histograms
        fg = histcounts(gray(msk), 0:8:256);
        bg = histcounts(gray(not(msk)), 0:8:256);
        all = histcounts(gray, 0:8:256);
        red = histcounts(color(:,:,1), 0:8:256);
        green = histcounts(color(:,:,2), 0:8:256);
        blue = histcounts(color(:,:,3), 0:8:256);
        
        
        % normalize histograms
        fg = fg ./ sum(fg);
        bg = bg ./ sum(bg);
        all = all ./ sum(all);
        red = red ./ sum(red);
        green = green ./ sum(green);
        blue = blue ./ sum(blue);

        color_features(i,:) = [fg, bg, all, red, green, blue];
    end
end

