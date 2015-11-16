
[X, mX, sX, Y] = load_data('../data/train.csv');

nrem_or_rest = Y == 0 | Y == 1;
rem_or_rest = Y == 0 | Y == 2;
wake_or_rest = Y == 1 | Y == 2;

nrem_params = find_params(X, nrem_or_rest);
rem_params = find_params(X, rem_or_rest);
wake_params = find_params(X, wake_or_rest);

m_nrem = fitcsvm(X, nrem_or_rest, 'BoxConstraint', nrem_params(1), 'KernelFunction', 'rbf', 'KernelScale', nrem_params(2));
m_rem = fitcsvm(X, rem_or_rest, 'BoxConstraint', rem_params(1), 'KernelFunction', 'rbf', 'KernelScale', rem_params(2));
m_wake = fitcsvm(X, wake_or_rest, 'BoxConstraint', wake_params(1), 'KernelFunction', 'rbf', 'KernelScale', wake_params(2));

[T, ix] = load_test('../data/validate_and_test.csv', mX, sX);

[~, score_wake] = predict(m_wake, T);
[~, score_rem] = predict(m_rem, T);
[~, score_nrem] = predict(m_nrem, T);

[orows, ~] = size(T);

pred = zeros(orows, 3);

for i = 1:orows
    pred(i, 1) = score_wake(i, 1);
    pred(i, 2) = score_rem(i, 1);
    pred(i, 3) = score_nrem(i, 1);
end

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