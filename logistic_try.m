addpath('liblinear');

Y_full=full(Y);
load 'words_train.mat'
full_mat = full(X);
errs = zeros(1, 10);
kinds = crossvalind('Kfold', 4500, 10);
logistic_model=cell(10,2);
for cross = 1:10
%     cov_full = cov(full_mat(kinds ~= cross, :));
%     [c_t, l_cov] = pcacov(cov_full);
    %[c_t, ~, l_cov] = pca(full_mat(kinds ~= cross, :));
    XTest = full_mat(kinds == cross, :);
    XTrain = full_mat(kinds ~= cross , :);
    
    YTest = Y(kinds == cross);
    YTrain = Y(kinds ~= cross);
    
    %[logistic_model{cross,1},logistic_model{cross,2}]=logistic(XTrain,YTrain,XTest,YTest);
    %errs(cross) = max(sum(YTest == logistic_model{cross,1}));
end
errs/450;
[logistic_model_full_data]=logistic(X,full(Y));
save('logistic_save.mat','logistic_model_full_data');
    %[logistic_model{cross,1} logistic_model{cross,2},logistic_model{cross,3}]=logistic(XTrain,YTrain,XTest,YTest);
    
    %labels=predict(logistic_model{cross},XTest);
    %labels = logistic_model{cross,1}  %, sum(YTest == 0))
    %errs(cross) = max(sum(YTest == labels))
    
    %errs(cross) = max(sum(YTest ==)

% errs/450
% model=logistic_model{find(errs==max(errs)),3};
% save('svm_logistic.mat','model');
    %     for i = 1:2
%         gmMod{i} = fitgmdist(XTrain(YTrain == (i-1), :) * c_t(:, 1:1000), 10, ...
%             'Option', statset('MaxIter', 2000), 'RegularizationValue', 1e-5);
%         disp(i)
%         pdfs(:, i) = pdf(gmMod{i}, XTest * c_t(:, 1:1000));
%     end
    
    
    % Get the corresponding letter
    %[~, tryLetter] = max(pdf2, [], 2);
    
    %errs(cross) = max(sum(YTest == -(tryLetter - 2)), sum(YTest == (tryLetter - 1)))
    % sum(testset.letter == tryLetter)/length(tryLetter)

%svm=svmtrain(raw_tweets_train{1,2},Y