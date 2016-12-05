Y_full=full(Y);
load 'words_train.mat'
full_mat = full(X);
nb_model = fitcnb(X, full(Y));
[logistic_model_full_data]=logistic(X,full(Y));
knn_model = fitcknn(X, full(Y), 'NumNeighbors', 7);

save('logistic_save.mat','logistic_model_full_data');
save('nb_save.mat', 'nb_model');
save('knn_save.mat', 'knn_model');