function u = tridiag_thomas(a, b, c, r)
%TRIDIAG_THOMAS Solves a tridiagonal system using Thomas algorithm.
%
%   u = TRIDIAG_THOMAS(a, b, c, r)
%
%   Inputs:
%       a: Vector with elements on the diagonal below the main diagonal
%          (n elements, first element is not used).
%       b: Vector with elements on the main diagonal (n elements).
%       c: Vector with elements on the diagonal above the main diagonal
%          (n elements, last element is not used).
%       r: Right-hand side vector (n elements).
%
%   Outputs:
%       u: Solution vector (n elements).
%
%   Adapted from:
%   W. H. Press, S. A. Teukolsky, W. T. Vetterling, B. P. Flannery,
%   Numerical Recipes – The Art of Scientific Computing, 3rd Edition,
%   Cambridge University Press, 2007, Ch. 2.4, pp. 56–57.

% if (b(1)==0)
%     fprintf('Reorder the equations for the tridiagonal solver...') 
%     pause
% end

% define vectors
n = length(a);
gamma = zeros(n,1);
u = zeros(n,1);

beta = b(1) ;
u(1) = r(1)/beta ;
% Start the decomposition and forward substitution
for j = 2:n
    gamma(j) = c(j-1)/beta ;
    beta = b(j)-a(j)*gamma(j) ;
%     if (beta==0)
%         fprintf('The tridiagonal solver failed...') 
%         pause
%     end
    u(j) = (r(j)-a(j)*u(j-1))/beta ;
end
% Perform the backsubstitution
for j = 1:(n-1)
    k = n-j ;
    u(k) = u(k) - gamma(k+1)*u(k+1) ;
end
