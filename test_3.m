function [a,b,r] = test_3(n)
if nargin == 0
    n = 100;
end
a = -1 + 2*rand(1,n);
b = -1 + 2*rand(1,n-1);
i = ceil(n/2);
b(i) = b(i)*1e-50;
r = ones(1,n);
