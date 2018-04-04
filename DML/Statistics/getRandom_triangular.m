function x = getRandom_triangular(mean, radius, M)
%GETRANDOM_TRIANGULAR Random numbers in triangular distribution.
%   X = GETRANDOM_TRIANGULAR(MEAN, SIZE) returns M random numbers in an
%   isotropic triangular kernel of given radius. The functions works for
%   univariate (mean and point are scalars) and multivariate distributions
%   (mean is 1xN).
%
%   The result is of dimensions NxM.

%   Author: Damien Teney

% Check the arguments
if (nargin < 3)
  M = 1; % Default value
end

N = length(mean); % Number of dimensions
for j = 1:N % For each dimension
  a = mean(j) - radius; % Lower limit of distribution
  b = mean(j) + radius; % Upper limit of distribution

  u = rand(M, 1);
  lo = (u < 0.5);
  x(lo, j) = a + radius .* sqrt(2 * u(lo));
  x(~lo, j) = b - radius .* sqrt(2 * (1 - u(~lo)));
end
