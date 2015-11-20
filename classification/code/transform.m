function M = transform(X)
%TRANSFORM is applying feature transformations
%
%   X     Matrix of data on which you want to perform feature transformations
%
%   M     Final Matrix with all the feature transformations

    % Apply sqrt to the last column
    M = [X(:,1:end-1) (sqrt(1 + X(:, end)))];
    
    % Add new dimensions containing the square of the first columns
    M = [M M(:,1:end-1).^2];
    
end

