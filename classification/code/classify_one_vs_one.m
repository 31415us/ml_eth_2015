
[X, mX, sX, Y] = load_data('../data/train.csv');

wake_or_rem = Y == 0 | Y == 1;
wake_or_nrem = Y == 0 | Y == 2;
rem_or_nrem = Y == 1 | Y == 2;

wake_rem_params = find_params(X(wake_or_rem, :), Y(wake_or_rem));
wake_nrem_params = find_params(X(wake_or_nrem, :), Y(wake_or_nrem));
rem_nrem_params = find_params(X(rem_or_nrem, :), Y(rem_or_nrem));

m_wake_rem = fitcsvm(X(wake_or_rem, :), Y(wake_or_rem), 'BoxConstraint', wake_rem_params(1), 'KernelFunction', 'rbf', 'KernelScale', wake_rem_params(2));
m_wake_nrem = fitcsvm(X(wake_or_nrem, :), Y(wake_or_nrem), 'BoxConstraint', wake_nrem_params(1), 'KernelFunction', 'rbf', 'KernelScale', wake_nrem_params(2));
m_rem_nrem = fitcsvm(X(rem_or_nrem, :), Y(rem_or_nrem), 'BoxConstraint', rem_nrem_params(1), 'KernelFunction', 'rbf', 'KernelScale', rem_nrem_params(2));

[T, ix] = load_test('../data/validate_and_test.csv', mX, sX);

[~, score_01] = predict(m_wake_rem, T);
[~, score_02] = predict(m_wake_nrem, T);
[~, score_12] = predict(m_rem_nrem, T);

[orows, ~] = size(T);

pred = zeros(orows, 3);

for i = 1:orows
    pred(i, 1) = score_01(i, 1) + score_02(i, 1);
    pred(i, 2) = score_01(i, 2) + score_12(i, 1);
    pred(i, 3) = score_02(i, 2) + score_12(i, 2);
end

disp(pred);

[max_elem, index_of_max] = max(transpose(pred));

output = [ix, transpose(index_of_max) - 1];

%{
pred = [predict(m_wake_rem, T), predict(m_wake_nrem, T), predict(m_rem_nrem, T)];

out = transpose(mode(transpose(pred)));

disp(out);

output = [ix, uint32(out)];
%}

fid = fopen('../data/out.csv', 'w');
fprintf(fid,'Id,Label\n');
fclose(fid);
format long
dlmwrite('../data/out.csv', output, '-append');