function lbp = load_lbp_features(img_ids, image_dir)

    [num_ids, ~] = size(img_ids);
    
    lbp = zeros(num_ids, 40);
    
    for i = 1:num_ids
        img_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_raw.tif');
        gray = rgb2gray(imread(img_path));
        lbp(i, :) = extractLBPFeatures(gray, 'Upright', false, 'CellSize', [32, 32]);
    end
end

