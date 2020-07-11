function [a,b,r] = test_7(n)
if nargin == 0
    n = 100;
end
A = inv(gallery('kms', n, 0.5));
a = diag(A).';
b = diag(A,-1)';
r = ones(1,n);