function x = tridiag_gauss(d, a, c, b)
%TRIDIAG_GAUSS Solves a tridiagonal system using Gaussian elimination.
%
%   u = TRIDIAG_GAUSS(d, a, c, b)
%
%   Inputs:
%       d: Vector with elements on the main diagonal (n elements).
%       a: Vector with elements on the diagonal below the main diagonal
%          (n elements, first element is not used).
%       c: Vector with elements on the diagonal above the main diagonal
%          (n elements, last element is not used).
%       b: Right-hand side vector (n elements).
%
%   Outputs:
%       x: Solution vector (n elements).
%
%   Adapted from:
%   D. Kincaid, W. Cheney, Numerical Analysis – Mathematics of Scientific
%   Computing, American Mathematical Society, 2002, Ch. 4.3, pp. 179–180.

% define otuput vector
n=length(d);
x=zeros(n,1);
% forward elimination
for i = 2:n
    f = a(i)/d(i-1);
    d(i) = d(i) - f*c(i-1);
    b(i) = b(i) - f*b(i-1);
end
% back substitution
x(n) = b(n)/d(n);
for i = n-1:-1:1
    x(i) = (b(i)-c(i)*x(i+1))/d(i);
end
