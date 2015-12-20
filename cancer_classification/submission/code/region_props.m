function out = region_props(img, msk)
    p = regionprops(msk, img, 'Area', 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'Solidity', 'Extent', 'Perimeter', 'MeanIntensity', 'MinIntensity', 'MaxIntensity');
    out = zeros(1, 12);
    out(:,1) = p.Area;
    out(:,2) = p.MajorAxisLength;
    out(:,3) = p.MinorAxisLength;
    out(:,4) = p.Eccentricity;
    out(:,5) = p.ConvexArea;
    out(:,6) = p.EquivDiameter;
    out(:,7) = p.Solidity;
    out(:,8) = p.Extent;
    out(:,9) = p.Perimeter;
    out(:,10) = p.MeanIntensity;
    out(:,11) = p.MinIntensity;
    out(:,12) = p.MaxIntensity;
end

