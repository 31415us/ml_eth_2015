function out = load_region_props(img_ids, img_dir)

    [num_ids, ~] = size(img_ids);
    
    out = zeros(num_ids, 10);
    
    for i = 1:num_ids
        msk_path = strcat(img_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        img_path = strcat(img_dir, sprintf('%04d', img_ids(i)), '_raw.tif');       
        bw = logical(im2double(imread(msk_path))); 
        gray = rgb2gray(imread(img_path));
        p = regionprops(bw, gray, 'Area', 'MajorAxisLength', 'MinorAxisLength', 'Eccentricity', 'EquivDiameter', 'Solidity', 'Extent', 'MeanIntensity', 'MinIntensity', 'MaxIntensity');
        
        % if there are multiple regions use props of biggest one
        [~, index] = max([p.Area]);
        p = p(index);
        
        % make types work out
        p.MinIntensity = double(p.MinIntensity);
        p.MaxIntensity = double(p.MaxIntensity);
        
        out(i, :) = struct2array(p);
    end
end

