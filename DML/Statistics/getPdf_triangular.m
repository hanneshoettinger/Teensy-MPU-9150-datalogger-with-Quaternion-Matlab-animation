function p = getPdf_triangular(point, mean, radius)
%GETPDF_TRIANGULAR Probability in isotropic triangular kernel.
%   P = GETPDF_TRIANGULAR(POINT, MEAN, SIZE) returns the probability
%   density of the given point in an isotropic triangular kernel of given
%   radius. The functions works for univariate (MEAN and POINT are scalars)
%   and multivariate distributions (MEAN and POINT are 1xN
%   vectors).
%
%   POINTS can also contain several points (MxN), P is then of dimension
%   1xM.

%   Author: Damien Teney

% Check dimensions
%assert(size(point, 2) == size(mean, 2)); % Debug

M = size(point, 1); % Number of points
N = size(point, 2);  % Number of dimensions

% Evaluate pdf
tmp = point - mean(ones(M, 1), :); % Substract 'mean' (1xN) from each row of 'point' (MxN)
distanceToMean = sqrt(sum(tmp.^2, 2)); % Get the norm of each row

% Fill in output vector (1xM)
triangleHeight = 1 / radius;
p(1, :) = triangleHeight * ((radius - distanceToMean) / radius); % Normal case
p(1, distanceToMean >= radius) = 0; % Special case: out of the kernel
