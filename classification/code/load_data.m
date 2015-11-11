function [ Xdata, Ydata ] = load_data( input_path )
%LOAD_DATA Summary of this function goes here
%   input_path     path to the file containing the datas
%
%   xData          input datas
%   yData          output datas or class
    
    M = csvread(input_path);
    
    % Separate the indices, the XData and the YData
    Xdata = M(:,2:end-1);
    Ydata = M(:,end);
    
    disp('Data loaded successfully.');

end