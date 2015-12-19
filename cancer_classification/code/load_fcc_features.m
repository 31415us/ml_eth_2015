function out = load_fcc_features(img_ids, image_dir)
%LOAD_FCC_FEATURES compute the Freeman Chain Code (fcc) for every cell
%
%   Freeman Chain Code, FCC: FCC describes the nucleus? boundary as a
%   string of numbers from 1 to 8, representing the direction of the 
%   boundary line at that point ([8]). The boundary is discretized by 
%   subsampling with grid size 8. For rotational invariance, the first 
%   difference of the FCC with minimum magnitude is used. The FCC is 
%   represented in a 8-bin histogram.

    [num_ids, ~] = size(img_ids);
    
    out = zeros(num_ids, 8);
    
    for i = 1:num_ids
        msk_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        
        msk = im2bw(imread(msk_path));
        msk_perim = bwperim(msk);
        
        % Remove external line
        msk_perim(1,:) = 0;
        msk_perim(end,:) = 0;
        msk_perim(:,1) = 0;
        msk_perim(:,end) = 0;
        
        % ----- DEBUG -----
%         disp(msk_path);
%         subplot(1,2,1), imshow(msk);
%         subplot(1,2,2), imshow(msk_perim);
%         pause;
        
        
        % TODO cell can separate in multiple smaller cell, find better way
        % to select cell
        [x_perim, y_perim] = find(msk_perim);
        
        coord_perim = bwtraceboundary(msk_perim,[x_perim(1) y_perim(1)],'W',8,Inf,'counterclockwise');
        
        fcc = chaincode(coord_perim);
        h = histcounts(fcc.code);
        h_norm = h - min(h);
        ix = find(h_norm == 0);
        s = circshift(h_norm, [0, -(ix - 1)]);
        out(i, :) = s ./ sum(s);
    end
end

