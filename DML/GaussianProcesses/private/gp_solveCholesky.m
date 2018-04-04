function X = gp_solveCholesky(L, B)
%GP_SOLVECHOLESKY Linear equations solver from Cholesky factorization.
%   X = GP_SOLVECHOLESKY(L, B) solves A*X = B for X, where A is square,
%   symmetric, positive definite. The input to the function is R the
%   Cholesky decomposition of A and the matrix B.
%
%   Example: X = solve_chol(chol(A),B);

%   Author: inspired by code of C. E. Rasmussen, H. Nickisch
%   (http://gaussianprocess.org/gpml/code), modified by Damien Teney

if size(L, 1) ~= size(L, 2) || ...
   size(L, 1) ~= size(B, 1)
  error('Wrong sizes of matrix arguments.');
end

X = L \ (L' \ B);
