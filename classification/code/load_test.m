function [ index_start, Xdata ] = load_test( input_path )
%LOAD_TEST loads the data to test
%   index_start  first index in the table
%   input_path   path to the file containing the datas
%
%   xData        input datas

    M = csvread(input_path);
    
    % Separate the indices and the Xdata
    index_start = M(1,1);
    Xdata = M(:,2:end);
    
    disp('Datas to test loaded successfully.');

end

