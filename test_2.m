function [a,b,r] = test_2(n)
if nargin == 0
    n = 100;
end
A = gallery('dorr', n, 1e-4);
a = diag(A).';
b = sqrt(diag(A,-1).*diag(A,1)).';
if ~all(b == real(b))
    error('Negative number in product diag(A,-1).*diag(A,1)')
end
r = ones(1,n);
