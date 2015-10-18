%% Control Variables
filename = 'data/train.csv'; % File containing the Training Data
rmIndexes = true; % Remove first column of the dataSet if contains the indexes
normalization = true; % Activate or Desactivate the feature Normalization
learningRate = 0.01; % Learning rate for the gradient descent
repetition = 3000; % Number of repeticion of the gradient descent algorithm


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

xDataSet = [ones(mDS, 1) xDataSet]; % Add one column of 1 to include \theta_0

parameters = zeros(size(xDataSet, 2),1); % Initiate the matrix of theta

costFctOverRept = ones(repetition, 1);

% Running gradient descent

disp('Computing the Gradient Descent...');

for i = 1:repetition
    Xtheta = xDataSet * parameters;
    parameters = parameters - (learningRate/mDS) * xDataSet'*(Xtheta-yDataSet);
    
    % Compute the cost function for this iteration
    costFctOverRept(i) = (1/2*mDS)*(Xtheta-yDataSet)'*(Xtheta-yDataSet);
end

% TODO
disp('           |    25%   50%   75%    |');
disp('Progress : |=====|=====|=====|=====|');
disp('Gradient Descent computed successfully.')

% Plot the cost function over the number of repeticion
figure
plot(costFctOverRept);
title('Cost Function Over Repeticion');
xlabel('#Repetition');
ylabel('Cost Function');
