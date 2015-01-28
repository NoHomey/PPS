% kNN explanation with fisheriris
% Matlab help file
% D. Nikolov;
% 21 Jan 2015
clear all; clc;
load fisheriris % load the data 

% separate the data
x = meas(:,3:4);

%plot splited data
gscatter(x(:,1),x(:,2),species);
set(legend,'location','best');

% create newpoint
newpoint = [5 1.45];
line(newpoint(1),newpoint(2),'marker','x','color','k',...
'markersize',10,'linewidth',2)

% kNN search in the input space for the created point
[n,d] = knnsearch(x,newpoint,'k',1,'Distance','euclidean')
line(x(n,1),x(n,2),'color',[.5 .5 .5],'marker','o',...
'linestyle','none','markersize',10)

[n,d] = knnsearch(x,newpoint,'k',2, 'Distance','minkowski','P',3)
line(x(n,1),x(n,2),'color',[.5 .5 .5],'marker','o',...
'linestyle','none','markersize',10)

% create new 10 points 
[n,d] = knnsearch(x,newpoint,'k',10);
line(x(n,1),x(n,2),'color',[.5 .5 .5],'marker','o',...
'linestyle','none','markersize',10)

x(n,:)

set(gca,'xlim',[4.5 5.5],'ylim',[1 2]); axis square
tabulate(species(n))

% plot the circle around all points 
ctr = newpoint - d(end);
diameter = 2*d(end);
h = rectangle('position',[ctr,diameter,diameter],...
'curvature',[1 1]);
set(h,'linestyle',':');

% create and plot 3 newpoints
figure
newpoint2 = [5 1.45;6 2;2.75 .75];
gscatter(x(:,1),x(:,2),species)
legend('location','best')

%search input for those points
[n2,d2] = knnsearch(x,newpoint2,'k',10);
line(x(n2,1),x(n2,2),'color',[.5 .5 .5],'marker','o',...
'linestyle','none','markersize',10)

line(newpoint2(:,1),newpoint2(:,2),'marker','x','color','k',...
'markersize',10,'linewidth',2,'linestyle','none')
tabulate(species(n2(1,:)))

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
