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
    maxDataSet = max(xDataSet); % Get the maximum in each column
    minDataSet = min(xDataSet); % Get the minimum in each column
    meanDataSet = mean(xDataSet); % Get the mean in each column
    
    % Substract the Mean of the column for each value
    xDataSetMinusMean = xDataSet - repmat(meanDataSet, mDS, 1);
    
    % Divide by the range for each value
    rangeDataSet = repmat(maxDataSet - minDataSet, mDS, 1); % Create range matrix
    xDataSet = xDataSetMinusMean ./ rangeDataSet;
    
    % Print the sucess message
    msg = 'Training data normalized successfully.\n';
    fprintf(msg);
    
end

%% Gradient Descent
% http://www.codeproject.com/Articles/879043/Implementing-Gradient-Descent-to-Solve-a-Linear-Re

