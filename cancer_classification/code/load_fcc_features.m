function fcc = load_fcc_features(img_ids, image_dir)
%LOAD_FCC_FEATURES compute the Freeman Chain Code (fcc) for every cell
%
%   Freeman Chain Code, FCC: FCC describes the nucleus? boundary as a
%   string of numbers from 1 to 8, representing the direction of the 
%   boundary line at that point ([8]). The boundary is discretized by 
%   subsampling with grid size 8. For rotational invariance, the first 
%   difference of the FCC with minimum magnitude is used. The FCC is 
%   represented in a 8-bin histogram.

    [num_ids, ~] = size(img_ids);
    
    fcc = zeros(num_ids, 1);
    
    for i = 1:num_ids
        msk_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        
        msk = im2bw(imread(msk_path));
        msk_perim = ~bwperim(msk, 1);
        
        % Remove external line
        msk_perim(1,:) = 0;
        msk_perim(end,:) = 0;
        msk_perim(:,1) = 0;
        msk_perim(:,end) = 0;
        
        % TODO cell can separate in multiple smaller cell, find better way
        % to select cell
        [x_perim, y_perim] = find(msk_perim);
        
        coord_perim = bwtraceboundary(msk_contour,[x_perim(1) y_perim(1)],'W',8,Inf,'counterclockwise');
        
        fcc(i,:) = chaincode(coord_perim);
    end


end
