function [ XYdata, Xdata, Ydata ] = load_data( input_path )
%LOAD_DATA loads the training data
%   input_path     path to the file containing the datas
%
%   xData          input datas
%   yData          output datas or class
    
    M = csvread(input_path);
    
    % Separate the indices, the Xdata and the Ydata
    Xdata = M(:,2:end-1);
    Ydata = M(:,end);
    XYdata = [Xdata Ydata];
    
    disp('Training datas loaded successfully.');

end