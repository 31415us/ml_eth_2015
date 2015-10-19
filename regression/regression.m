%% Control Variables
filenameTrain = 'data/train.csv'; % File containing the Training Data
filenameValidate = 'data/validate_and_test.csv'; % File containing the data to validate
filenameResult = 'result.csv'; % Name of the file to create 

rmIndexes = true; % Remove first column of the dataSet if contains the indexes

normalization = true; % Activate or Desactivate the feature Normalization
normOpti = true; % Use the informations given to normalize (NOT BETTER!!!!)
rangeOpti = [6 128 72 72 120 14 7 31000 768 24 960 960 7488 27];
meanOpti = [5 96 44 44 100 9 4.5 16500 640 20 544 544 4256 22.5];

learningRate = 0.01; % Learning rate for the gradient descent
repetition = 3000; % Number of repeticion of the gradient descent algorithm

%% Import Training Data
% Import all the data set from the csv file
dataSet = csvread(filenameTrain);

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
    if (normOpti)
        xDataSetMinusMean = xDataSet - repmat(meanOpti, mDS, 1);
        xDataSet = xDataSetMinusMean ./ repmat(rangeOpti, mDS, 1);
        
    else
        maxDataSet = max(xDataSet); % Get the maximum in each column
        minDataSet = min(xDataSet); % Get the minimum in each column
        meanDataSet = mean(xDataSet); % Get the mean in each column

        % Substract the Mean of the column for each value
        xDataSetMinusMean = xDataSet - repmat(meanDataSet, mDS, 1);

        % Divide by the range for each value
        rangeDataSet = repmat(maxDataSet - minDataSet, mDS, 1); % Create range matrix
        xDataSet = xDataSetMinusMean ./ rangeDataSet;
    end
    
    % Print the sucess message
    msg = 'Training data normalized successfully.\n';
    fprintf(msg);
    
end

%% Gradient Descent

xDataSet = [ones(mDS, 1) xDataSet]; % Add one column of 1 to include \theta_0

parameters = zeros(size(xDataSet, 2),1); % Initiate the matrix of theta

costFctOverRept = ones(repetition, 1);

% Running gradient descent

fprintf('Computing the Gradient Descent...');
reverseStr = ''; % Use to print the percentage

for i = 1:repetition
    Xtheta = xDataSet * parameters;
    parameters = parameters - (learningRate/mDS) * xDataSet'*(Xtheta-yDataSet);
    
    % Compute the cost function for this iteration
    costFctOverRept(i) = (1/2*mDS)*(Xtheta-yDataSet)'*(Xtheta-yDataSet);
    
     % Display the progress
     percentDone = 100 * i / repetition;
     msg = sprintf('%3.1f', percentDone);
     fprintf([reverseStr, msg]);
     reverseStr = repmat(sprintf('\b'), 1, length(msg));
end

fprintf('\nGradient Descent computed successfully.\n')

figure;
% Plot the cost function over the number of repeticion
subplot(1,2,1);
plot(costFctOverRept);
title('Cost Function Over Repeticion');
xlabel('#Repetition');
ylabel('Cost Function');

% Plot the difference between the train value and the validate one
result4dataset = xDataSet * parameters;
diffDataSetResult = yDataSet - result4dataset;

subplot(1,2,2);
plot((1:mDS)', diffDataSetResult); % Plot with x starting at 1
title('Difference between DataSet and computed values');
xlabel('Id Data Set');
ylabel('Difference');

%% Import Data to Validate
% Import all the data set from the csv file
data2validate = csvread(filenameValidate);

% Remove indexes
indexesValidate = data2validate(:,1);
data2validate = data2validate(:,2:end);


%% Normalize Data to Validate
if (normalization)
    mDV = size(data2validate,1); % Number of Entries in the data to validate
    
    if (normOpti)
        data2validateMinusMean = data2validate - repmat(meanOpti, mDV, 1);
        data2validate = data2validateMinusMean ./ repmat(rangeOpti, mDV, 1);
    
    else
        % Substract the Mean of the column for each value
        data2validateMinusMean = data2validate - repmat(meanDataSet, mDV, 1);

        % Divide by the range for each value
        rangeDataSet = repmat(maxDataSet - minDataSet, mDV, 1); % Create range matrix
        data2validate = data2validateMinusMean ./ rangeDataSet;
    
    end
    % Print the sucess message
    msg = 'Data to validate normalized successfully.\n';
    fprintf(msg);
    
end

%% Computing the Data to Validate

% Add a column of 1
data2validate = [ones(size(data2validate,1), 1) data2validate];

% Compute the result
validateData = data2validate * parameters;

% Put back the index
validateData = [indexesValidate validateData];

% Write to the csv file
fid = fopen(filenameResult, 'w');
fprintf(fid, 'Id,Delay\n');
fclose(fid);

format long
dlmwrite(filenameResult, validateData, '-append');

fprintf('Validate data exported successfully.\n')

