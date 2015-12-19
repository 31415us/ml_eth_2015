function [fcc_out, num_obj] = load_fcc_features(img_ids, image_dir)
%LOAD_FCC_FEATURES compute the Freeman Chain Code (fcc) for every cell
%
%   Freeman Chain Code, FCC: FCC describes the nucleus? boundary as a
%   string of numbers from 1 to 8, representing the direction of the 
%   boundary line at that point ([8]). The boundary is discretized by 
%   subsampling with grid size 8. For rotational invariance, the first 
%   difference of the FCC with minimum magnitude is used. The FCC is 
%   represented in a 8-bin histogram.

    [num_ids, ~] = size(img_ids);
    
    fcc_out = zeros(num_ids, 8);
    num_obj = zeros(num_ids, 1);
    
    for i = 1:num_ids
        msk_path = strcat(image_dir, sprintf('%04d', img_ids(i)), '_msk.png');
        
        msk = ~im2bw(imread(msk_path));
        
        CC = bwconncomp(msk);
        numPixels = cellfun(@numel,CC.PixelIdxList);
        
        num_obj(i,:) = CC.NumObjects;
        
        % Isolate the biggest region
        msk_biggest = zeros(CC.ImageSize(1), CC.ImageSize(2));
        [~,idx] = max(numPixels);
        msk_biggest(CC.PixelIdxList{idx}) = 1;
        
        % Find the perimeter of the biggest region
        msk_perim = bwperim(msk_biggest);
        
        % ----- DEBUG -----
%         disp(msk_path);
%         subplot(1,3,1), imshow(msk);
%         subplot(1,3,2), imshow(msk_biggest);
%         subplot(1,3,3), imshow(msk_perim);
%         pause;
        
        [x_perim, y_perim] = find(msk_perim);
        
        coord_perim = bwtraceboundary(msk_perim,[x_perim(1) y_perim(1)],'W',8,Inf,'counterclockwise');
        
        fcc = chaincode(coord_perim);
        fcc_norm = normalizeFCC(fcc.code);
        h = histcounts(fcc_norm,0:8);
        fcc_out(i, :) = h ./ sum(h);
        
    end
end

function fcc_normalized = normalizeFCC (fcc)
    
    % Transpose fcc
    fcc = fcc';
    
    % Compute the first difference of the fcc
    shift_fcc = circshift(fcc, [0, -1]); % Shift input left by 1 location.
    delta_fcc = shift_fcc - fcc;
    i_neg = find(delta_fcc < 0);
    delta_fcc(i_neg) = delta_fcc(i_neg) + 8;
    
    % Find the integer of minimum magnitude in fcc
    
    % The integer of minimum magnitude starts with min(delta_fcc), but there
    % may be more than one such value. Find them all,
    i_min_fcc = find(delta_fcc == min(delta_fcc));
   
    % and shift each one left so that it starts with min(delta_fcc).
    J = 0;
    A = zeros(length(i_min_fcc), length(delta_fcc));
    for k = i_min_fcc;
       J = J + 1;
       A(J, :) = circshift(delta_fcc,[0 -(k-1)]);
    end 
    
    % Matrix A contains all the possible candidates for the integer of
    % minimum magnitude. Starting with the 2nd column, succesively find
    % the minima in each column of A. The number of candidates decreases
    % as the seach moves to the right on A.  This is reflected in the
    % elements of J.  When length(J)=1, one candidate remains.  This is
    % the integer of minimum magnitude. 
    
    [M, N] = size(A);
    J = (1:M)';
    for k = 2:N
       D(1:M, 1) = Inf;
       D(J, 1) = A(J, k);
       amin = min(A(J, k));
       J = find(D(:, 1) == amin);
       if length(J)==1
          fcc_normalized = A(J, :)';
          return
       end
    end
end

