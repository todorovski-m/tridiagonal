function res = tridiag_compare(input_fun)
% TRIDIAG_COMPARE Compares methods for solving tridiagonal systems.
%
%   res = TRIDIAG_COMPARE(@ex_1)
%   res = TRIDIAG_COMPARE(@ex_2)
%   res = TRIDIAG_COMPARE(@() ex_n(10000))
%
%   Inputs:
%     input_fun: Function handle to a function which returns vectors a, b
%                and r (see ex_1.m, ex_2.m, ex_n.m).
%                Vector a is with elements on the main diagonal (n elements).
%                Vector b is with elements on the diagonals below
%                  and above main diagonal (n-1 elements).
%                Vector r is right-hand side vector (n elements).
%   Outputs:
%       res: Structure array with results for each tested method.
%            It has the following fields:
%            name: name of the tested method
%            u:    solution vector
%            t:    elapsed time
%            err: infinite norm of the residual in the solution max(abs(A*u-r'))

% default argument
if nargin == 0
    input_fun = @ex_1;
end

% read input data
[a, b, r] = input_fun();
n = length(a);

% create matrix of the system to be used in A\r and norm(A*u-r',2)
A = sparse(1:n,1:n,a,n,n) + ...
    sparse(2:n,1:n-1,b,n,n) + ...
    sparse(1:n-1,2:n,b,n,n);

% display A if it is small
if n < 10
    disp(full(A));
end

m = 0; % initialize number of tests

% run tests
m = m + 1;
res(m).name = 'Matlab solver';
u = A\r';
f = @() A\r';
t = timeit(f);
res(m).u = u;
res(m).t = t;
res(m).err = norm(A*u-r',2)/norm(r,2);

m = m + 1;
res(m).name = 'Thomas algorithm';
u = tridiag_thomas([0 b], a, [b 0], r);
f = @() tridiag_thomas([0 b], a, [b 0], r);
t = timeit(f);
res(m).u = u;
res(m).t = t;
res(m).err = norm(A*u-r',2)/norm(r,2);

m = m + 1;
res(m).name = 'Gaussian elimination';
u = tridiag_gauss(a, [0 b], [b 0], r);
f = @() tridiag_gauss(a, [0 b], [b 0], r);
t = timeit(f);
res(m).u = u;
res(m).t = t;
res(m).err = norm(A*u-r',2)/norm(r,2);

m = m + 1;
res(m).name = 'Proposed method';
u = tridiag_ysum(a,b,r);
f = @() tridiag_ysum(a,b,r);
t = timeit(f);
res(m).u = u;
res(m).t = t;
res(m).err = norm(A*u-r',2)/norm(r,2);

m = m + 1;
res(m).name = 'Proposed method (raw)';
u = tridiag_ysum_raw(a,b,r);
f = @() tridiag_ysum_raw(a,b,r);
t = timeit(f);
res(m).u = u;
res(m).t = t;
res(m).err = norm(A*u-r',2)/norm(r,2);

% print results
fprintf('n = %i\n', n);
for i = 1:m
    fprintf('%-23s t = %.2e   err = %.2e\n',res(i).name, res(i).t, res(i).err);
end
