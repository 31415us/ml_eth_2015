function [] = merge_by_voting( files_path )
%MERGE_BY_VOTING Merge the output of multiple files using a voting system
%   
%   files_path       Vector containing all the path of the files to merge
%
%   Example : merge_by_voting({'outDT.csv'; 'outLDA.csv'; 'outMNB.csv'});

    num_of_files = size(files_path, 1); % Number of file to use in the voting
    
    % If there is more than 1 file
    if num_of_files > 1
        
        % Import the first file
        M = csvread(char(files_path(1)));
        start_index = M(1,1); % Keep the first index to recreate the file later one
        
        M_merge = M(:,2); % Start to create the matrix
        
        % Import the other matrix and merge them together
        for i = 2:num_of_files
            M = csvread(char(files_path(i)));
            M_merge = [M_merge M(:,2)];
            
        end

        final_votation = mode(M_merge, 2); % Voting (in case all are different, it is the smallest which is selected)
        
        write_results(start_index, final_votation);

    end

end

