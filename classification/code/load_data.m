function [ XYtrain, Xdata, index_start] = load_data( input_path_train, input_path_data )
%LOAD_DATA loads the training data
%   input_path_data     path to the file containing the datas
%   input_path_test     path to the file containing the datas to test
%
%   XYtrain          input datas to train
%   Xdata            input datas to test
%   index_start      first index in the data to test's table
%
%   Example of use : [XYtrain, Xdata, index_start] = load_data('data/train.csv', 'data/validate_and_test.csv');
    
    %% Load the data to train the classifier
    Mtrain = csvread(input_path_train);
    
    % Separate the indices, the training datas
    XYtrain = Mtrain(:,2:end);
    
    disp('[Success] Training datas loaded');
    
    % Features transformation
    XYtrain = [transform(XYtrain(:,1:end-1)) XYtrain(:, end)];
    
    %% Load the data to use within the trained classifier
    Mdata = csvread(input_path_data);
    
    % Separate the indices and the Xdata
    index_start = Mdata(1,1);
    Xdata = Mdata(:,2:end);
    
    % Feature transformation
    Xdata = transform(Xdata);
    
    disp('[Success] Test datas loaded');

end

% Function use to perform features transformations
function M = transform(X)
    
    reduced = [X(:,1:end-1) (sqrt(X(:, end)))];

    % Multiply them together
%     for i = 1:7
%         for j = i:7
%             reduced = [reduced sqrt((reduced(:,i) .* reduced(:,j)))];
%         end
%     end
%     

%     reduced = [reduced sqrt(X(:,1)) X(:,1).^2 X(:,1).^3 X(:,1).^4 exp(X(:,1)) log(X(:,1))];
      reduced = [reduced reduced(:,1:end-1).^2];

%     % Multiply the first columns by the last one
%     for i = 1:7
%         reduced = [reduced (reduced(:,i) .* reduced(:,7))];
%     end
%     
%     for i = 1:5
%         reduced = [reduced X(:,i).^3];
%     end
    
    M = reduced;
end