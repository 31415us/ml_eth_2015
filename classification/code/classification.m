[~, X_train, Y_trainfull] = load_data('/data/train.csv');
[index_start, X_test] = load_test('/data/validate_and_test.csv');
[X_prepfull, x_mean, x_var] = normalize(X_train);
X_testprep = zeros(size(X_test));
for i=1:size(X_test,2)
    X_testprep(:,i) = X_test(:,i) - x_mean(i);
    X_testprep(:,i) = X_test(:,i)/x_var(i);
end

%% Divide into train and test
X_prep = X_prepfull(1:1700, :);
Y_train = Y_trainfull(1:1700,:);
X_vir = X_prepfull(1701:end, :);
Y_vir = Y_trainfull(1701:end, :);

%% Discriminant Analysis
discrimType = 'linear';
%discrimType = 'quadratic';
%discrimType = 'diagLinear';
%discrimType = 'diagQuadratic';
%discrimType = 'pseudoLinear';
%discrimType = 'pseudoQuadratic';

delta = 1;

%obj = fitcdiscr(X_train, Y_train, 'CrossVal', 'on', 'KFold', 45);
LDA = fitcdiscr(X_prep, Y_train, 'DiscrimType', discrimType, 'Delta', delta);

LDAtesterror = sum(Y_vir ~= predict(LDA, X_vir))/size(X_vir,1)
LDAwholdeerror = sum(Y_trainfull ~= predict(LDA, X_prepfull))/size(X_prepfull,1)

Y_testLDA = predict(LDA, X_testprep);
write_results(index_start, Y_testLDA, 'outLDA.csv');

%% Multiclass naive Bayes
distname = 'kernel';
%distname = 'mn';
%distname = 'mvmn';
%distname = 'normal';

%kernel = 'box';
%kernel = 'epanechnikov';
%kernel = 'normal';
kernel = 'triangle';

support = 'positive';
%support = 'unbounded';

if strcmp(distname, 'kernel')
    MNB = fitcnb(X_prep, Y_train, 'DistributionNames', distname, 'Kernel', kernel, 'Support', support);
else
    MNB = fitcnb(X_prep, Y_train, 'DistributionNames', distname);
end

MNBtesterror = sum(Y_vir ~= predict(MNB, X_vir))/size(X_vir,1)
MNBwholdeerror = sum(Y_trainfull ~= predict(MNB, X_prepfull))/size(X_prepfull,1)

Y_testMNB = predict(MNB, X_testprep);
write_results(index_start, Y_testMNB, 'outMNB.csv');

%% Decision Tree
algorithm = 'Exact';
%algorithm = 'PullLeft';
%algorithm = 'PCA';
%algorithm = 'OVAbyClass';

maxnumcat = 10;

maxnumsplit = size(X_prep,1)-1;
%maxnumsplit = 200;

mergeleaves = 'on';
%mergeleaves = 'off';

minleaf = 1;
minparent = 10;

numvariables = 'all';
%numvariables = 10;

prunes = 'on';
%prunes = 'off';

prunec = 'error';
%prunec = 'impurity';


DT = fitctree(X_prep, Y_train, 'AlgorithmForCategorical', algorithm, 'MaxNumCategories', maxnumcat, 'MaxNumSplits', maxnumsplit, 'MergeLeaves', mergeleaves, 'MinLeafSize', minleaf, 'MinParentSize', minparent, 'NumVariablesToSample', numvariables, 'Prune', prunes, 'PruneCriterion', prunec);

%view(DT,'mode','graph');
DecT = prune(DT, 'Level', 8);
%DecT = prune(DT, 'Alpha', 0.03);
%DecT = prune(DT, 'Nodes', [1 2 3 4]);

%view(DecT,'mode','graph');

DecTtesterror = sum(Y_vir ~= predict(DecT, X_vir))/size(X_vir,1)
DecTwholdeerror = sum(Y_trainfull ~= predict(DecT, X_prepfull))/size(X_prepfull,1)


Y_testDT = predict(DecT, X_testprep);
write_results(index_start, Y_testDT, 'outDT.csv');