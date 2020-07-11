function [a,b,r] = test_10(n)
if nargin == 0
    n = 100;
end
A = gallery('randsvd',n,1e15,2,1,1);
a = diag(A).';
b = sqrt(diag(A,-1).*diag(A,1)).';
r = ones(1,n);
