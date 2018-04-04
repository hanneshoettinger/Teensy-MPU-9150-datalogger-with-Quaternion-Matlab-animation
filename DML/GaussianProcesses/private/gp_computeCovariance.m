function K = gp_computeCovariance(hyperparameters, x, z, i)
%GP_COMPUTECOVARIANCE Squared Exponential covariance.
%   K = GP_COMPUTECOVARIANCE(HYPERPARAMETERS, X, Z, I) computes the matrix
%   of squared exponential covariances with isotropic distance measure.
%   The covariance function is parameterized as:
%   k(x^p, x^q) = b^2 * exp(-(x^p - x^q)' * inv(P) * (x^p - x^q) / 2) 
%   where the P matrix is a^2 times the unit matrix and b^2 is the
%   signal variance.
%
%   Hyperparameters are given as a 2x1 vector:
%   [log(a); log(b)]

%   Author: inspired by code of C. E. Rasmussen, H. Nickisch
%   (http://gaussianprocess.org/gpml/code), modified by Damien Teney

if nargin < 3 % Make sure z exists
  z = [];
end

% Rename hyperparameters
a = exp(hyperparameters(1)); % Characteristic length scale
b = exp(2 * hyperparameters(2)); % Signal variance

if strcmp(z, 'diag') > 0
  %------------------------------------------------------------------------
  % Vector kxx
  %------------------------------------------------------------------------
  K = zeros(size(x, 1), 1);
  K = b * exp(-K / 2);
  return;

else
  if nargin < 4
    %----------------------------------------------------------------------
    % Cross covariances Kxz
    % (z can also be equal to x and we then compute the self covariance)
    %----------------------------------------------------------------------
    K = gp_computeSquaredDistances(x' / a, z' / a);
    K = b * exp(-K / 2);
    return;

  else
    %----------------------------------------------------------------------
    % Derivatives
    %----------------------------------------------------------------------
    K = gp_computeSquaredDistances(x' / a, z' / a);
    if i == 1
      K = b * exp(-K / 2) .* K;
      return;

    elseif i == 2
      K = b * exp(-K / 2) * 2;
      return;

    else
      error('Unknown hyperparameter');

    end
  end

end

%==========================================================================

function C = gp_computeSquaredDistances(a, b)
%GP_COMPUTESQUAREDDISTANCES Matrix of pairwise squared distances.
%   C = GP_COMPUTESQUAREDDISTANCES(A, B) computes the matrix of squared
%   distances between two sets of vectors, stored in the columns of the
%   two matrices, A (of size D by n) and B (of size D by m).
%
%   If only a single argument is given or the second matrix is empty, the
%   missing matrix is taken to be identical to the first.
%
%   A: size D x n
%   B: size D x m (or empty)
%   C: size n x m

% Check dimensions of inputs
assert(size(b, 1) == size(a, 1));
n = size(a, 2);
m = size(b, 2);

% Computation of a^2 - 2*a*b + b^2 is less stable than (a-b)^2 because numerical
% precision can be lost when both a and b have very large absolute value and the
% same sign. For that reason, we subtract the mean from the data beforehand to
% stabilise the computations. This is OK because the squared error is
% independent of the mean.

% Substract the mean
mu = (m / (n + m)) * mean(b, 2) + (n / (n + m)) * mean(a, 2);
a = bsxfun(@minus, a, mu);
b = bsxfun(@minus, b, mu);

C = bsxfun(@plus, ...
           sum(a .* a, 1)', ...
           bsxfun(@minus, sum(b .* b, 1), 2 * a' * b) ...
    );

C = max(C, 0); % Avoid negative values (due to numerical noise)
