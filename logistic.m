function [ model] = logistic( train_x, train_y)
    %train_x=full(train_x);
    train_y=full(train_y);
    model = train(train_y, sparse(train_x), ['-s 0', 'col']);
    save('logi.mat',model);
    %[predicted_label] = predict(test_y, sparse(test_x), model, ['-q', 'col']);
    %[predicted_label] = predict(test_y,sparse(test_x), model, ['-q', 'col']);
    %precision = 1 - sum(predicted_label~=test_y) / length(test_y);
end

