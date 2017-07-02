function [trainedClassifier, validationAccuracy] = trainClassifier(datasetTable)
% Convert input to table
datasetTable = table(datasetTable);
datasetTable.Properties.VariableNames = {'column'};
% Split matrices in the input table into vectors
datasetTable.column_1 = datasetTable.column(:,1);
datasetTable.column_2 = datasetTable.column(:,2);
datasetTable.column_3 = datasetTable.column(:,3);
datasetTable.column_4 = datasetTable.column(:,4);
datasetTable.column_5 = datasetTable.column(:,5);
datasetTable.column_6 = datasetTable.column(:,6);
datasetTable.column = [];
% Extract predictors and response
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5'};
predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.column_6;
% Train a classifier
template = templateSVM('KernelFunction', 'linear', 'PolynomialOrder', [], 'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
trainedClassifier = fitcecoc(predictors, response, 'Learners', template, 'Coding', 'onevsone', 'PredictorNames', {'column_1' 'column_2' 'column_3' 'column_4' 'column_5'}, 'ResponseName', 'column_6', 'ClassNames', [1 2 3]);

% Perform cross-validation
partitionedModel = crossval(trainedClassifier, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

%% Uncomment this section to compute validation predictions and scores:
% % Compute validation predictions and scores
% [validationPredictions, validationScores] = kfoldPredict(partitionedModel);