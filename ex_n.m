function [a,b,r] = ex_n(n)
if nargin == 0
    n = 5000;
end
a = [2 3*ones(1,n-2) 2];
b = -ones(1,n-1);
r = ones(1,n);