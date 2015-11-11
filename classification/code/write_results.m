function [] = write_results( index_start, output )
% Write the results in a correctly formatted file
%   index_start   first id to start indexing the output
%   output        vector only containing the different class

    [m,n] = size(output);

    % Create the vector of ids.
    ids = (index_start : index_start + (m - 1))';

    % Generate a single array with the Ids and output.
    res = horzcat(ids,output);

    %Convert the array to a table and add column headers.
    table = array2table(res, 'VariableNames', {'Id','Label'});

    %Write the obtained table to a CSV file.
    writetable(table, 'out.csv');

    disp('out.csv wrote successfully.');

end

