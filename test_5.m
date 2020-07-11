function [a,b,r] = test_5(n)
if nargin == 0
    n = 100;
end
a = 1e8*ones(1,n);
b = -1 + 2*rand(1,n-1);
r = ones(1,n);
