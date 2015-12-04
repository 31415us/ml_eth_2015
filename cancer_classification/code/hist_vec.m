function histogram_vec = hist_vec(img_id, prefix)
    
    path = strcat(prefix, sprintf('%04d', img_id), '_raw.tif');
    img = imread(path);
    
    counts = imhist(rgb2gray(img), 32);
    
    histogram_vec = transpose(counts);

end

