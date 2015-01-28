% kNN explanation with fisheriris
% Matlab help file
% D. Nikolov;
% 21 Jan 2015
clear all; clc;
load fisheriris % load the data 

% split dataset into 90x4
rng(3)
idx = randperm(150);
train = meas(idx(1:90), 1:4);
trainLabels = species(idx(1:90))

% rest (91-150)x4 will be classificated
test = meas(idx(91:150), 1:4);
testLabels = species(idx(91:150)) 
% create model (tested this one has haighest predict ration = 59/61) for
% MATlab higher then R2013b use mdl = fitcknn(train,trainLabels,'NumNeighbors',13,'Distance','minkowski')
mdl = ClassificationKNN.fit(train,trainLabels,'NumNeighbors',13,'Distance','minkowski')
% make a prediction based on the model
predicted = predict(mdl, test)
% check the prediction quality which is the sum of predicted labels.
sum(strcmp(predicted, testLabels))
