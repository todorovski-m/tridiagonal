clc; clear
% ill-conditioned cases to be tested
test_funs = {
    'test_1'
    'test_2'
    'test_3'
    'test_4'
    'test_5'
    'test_6'
    'test_7'
    'test_8'
    'test_9'
    'test_10'
    'test_11'
    'test_12'
};
n = size(test_funs, 1);

results = zeros(n, 4);
for i = 1:n
    disp(test_funs{i});
    fun_handle = str2func(test_funs{i});
    % matrix condition number
    [a, b] = fun_handle();
    A = diag(a) + diag(b,-1) + diag(b,1);
    cond_number = cond(A);
    % test algorithms
    res = tridiag_compare(fun_handle);
    % save results
    for j = 1:4
        results(i, j) = res(j).err;
    end
    results(i, 5) = cond_number;
end

% print results
fprintf('\n');
fprintf('        --------------- Method ---------------\n');
fprintf('Matrix');
fprintf('%10i', 1:4);
fprintf('  cond. num.\n');
for i = 1:n
    fprintf('%6i',i);
    fprintf('%10.2e',results(i,:)');
    fprintf('\n');
end