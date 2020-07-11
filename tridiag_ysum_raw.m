function u = tridiag_ysum_raw(a, b, r)
%TRIDIAG_YSUM_RAW Solves a symmetrical tridiagonal system using admittance
%                 summation method.
%   This version does not take care about possible zero division and it is
%   faster. For full version see tridiag_ysum.
%
%   u = TRIDIAG_YSUM_RAW(a, b, r)
%
%   Inputs:
%       a: Vector with elements on the main diagonal (n elements).
%       b: Vector with elements on the diagonals below and above main
%          diagonal (n-1 elements).
%       r: Right-hand side vector (n elements).
%
%   Outputs:
%       u: Solution vector (n elements).
%
% See also TRIDIAG_YSUM.

% define vectors
n = length(a);
u = zeros(n,1);
D = zeros(n,1);
% initial step
Y = a + [0 b] + [b 0];
% backward sweep
for k = n:-1:2
    i = k-1;
    D(k) = b(i)/(b(i)-Y(k));
    Y(i) = Y(i) + D(k)*Y(k);
    r(i) = r(i) + D(k)*r(k);
end
% forward sweep
u(1) = r(1)/Y(1);
for k = 2:n
    u(k) = D(k)*(u(k-1) - r(k)/b(k-1));
end
