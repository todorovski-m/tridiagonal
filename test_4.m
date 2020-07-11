function [a,b,r] = test_4(n)
if nargin == 0
    n = 100;
end
a = -1 + 2*rand(1,n);
b = -1 + 2*rand(1,n-1);
for i = 1:n-1
    if rand <= 0.5
        b(i) = 0;
    end
end
r = ones(1,n);
