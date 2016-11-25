% % Load the data
% load 'E:\Philip\Academics\Upenn\2016 Fall\CIS 520\Final\kit\final_project_kit\train_set\words_train.mat'
full_mat = full(X);
gmMod = cell(2, 1);
pdfs = zeros(450, 2);
errs = zeros(1, 10);
kinds = crossvalind('Kfold', 4500, 10);
for cross = 1:10
%     cov_full = cov(full_mat(kinds ~= cross, :));
%     [c_t, l_cov] = pcacov(cov_full);
    [c_t, ~, l_cov] = pca(full_mat(kinds ~= cross, :));
    XTest = X(kinds == cross, :);
    XTrain = X(kinds ~= cross , :);
    
    YTest = Y(kinds == cross);
    YTrain = Y(kinds ~= cross);
    
    for i = 1:2
        gmMod{i} = fitgmdist(XTrain(YTrain == (i-1), :) * c_t(:, 1:1000), 10, ...
            'Option', statset('MaxIter', 2000), 'RegularizationValue', 1e-5);
        disp(i)
        pdfs(:, i) = pdf(gmMod{i}, XTest * c_t(:, 1:1000));
    end
    
    % pB = repmat(letterProb', length(testset.letter), 1);
    % Solve for P(A = a) = sum P(A = a | B = b) * P(B = b)
    denomi = repmat(sum(pdfs.* .5, 2), 1, 2);
    
    % Get P(B = b | A = a)
    pdf2 = pdfs .* .5 ./ denomi;
    
    % Get the corresponding letter
    [~, tryLetter] = max(pdf2, [], 2);
    
    errs(cross) = max(sum(YTest == -(tryLetter - 2)), sum(YTest == (tryLetter - 1)))
    % sum(testset.letter == tryLetter)/length(tryLetter)
end
errs/450
