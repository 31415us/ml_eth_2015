%% Control Variables
filename = 'data/train.csv'; %File containing the Training Data
rmIndexes = true; %Remove first column of the dataSet if contains the indexes
normalization = true; %Activate or Desactivate the feature Normalization


%% Import Training Data
% Import all the data set from the csv file
dataSet = csvread(filename);

% Remove the index from the dataSet
if (rmIndexes)
    dataSet = dataSet(:,2:end);
end

% Separate the Features from the Result
[mDS,nDS] = size(dataSet); %Get the size of the data set matrix
xDataSet = dataSet(:,1:(nDS - 1));
yDataSet = dataSet(:,nDS);

% Print the sucess message
msg = ['Training data imported successfully.\n',...
    ' --> #Features : ', int2str(nDS - 1),'\n',...
    ' --> #Entries : ', int2str(mDS),'\n'];
fprintf(msg);

%% Feature Normalization
if (normalization)
    
end

%% Gradient Descent
% http://www.codeproject.com/Articles/879043/Implementing-Gradient-Descent-to-Solve-a-Linear-Re

