function u = tridiag_ysum(a, b, r)
%TRIDIAG_YSUM Solves a symmetrical tridiagonal system using admittance
%             summation method.
%
%   u = TRIDIAG_YSUM(a, b, r)
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
% See also TRIDIAG_YSUM_RAW.

% define vectors
n = length(a);
u = zeros(n,1);
D = zeros(n,1);
s = false(n,1); % special nodes where b(k-1)-Y(k) = 0
% initial step
Y = a + [0 b] + [b 0];
ro = r;
% backward sweep
k = n;
while k >= 2
    i = k-1;
    if b(i)-Y(k) ~= 0
        D(k) = b(i)/(b(i)-Y(k));
        Y(i) = Y(i) + D(k)*Y(k);
        r(i) = r(i) + D(k)*r(k);
    else
        j = k-2;
        Y(j) = Y(j) - b(j);
        r(j) = r(j) - b(j)*r(k)/Y(k);
        u(k-1) = r(k)/Y(k);
        s(k) = true;
        k = k - 1;
    end
    k = k - 1;
end
% forward sweep
u(1) = r(1)/Y(1);
for k = 2:n
    if D(k) ~= 0
        u(k) = D(k)*(u(k-1) - r(k)/b(k-1));
        continue
    end
    if b(k-1) == 0
        u(k) = r(k)/Y(k);
        continue
    end
    if s(k)
        u(k) = (ro(k-1) - b(k-2)*u(k-2) - a(k-1)*u(k-1))/b(k-1);
    end
end