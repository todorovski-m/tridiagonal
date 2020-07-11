function [a,b,r] = test_1(n)
if nargin == 0
    n = 100;
end
a = -1 + 2*rand(1,n);
b = -1 + 2*rand(1,n-1);
r = ones(1,n);
