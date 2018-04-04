function p = getPdf_circularTriangular(point, mean, radius)
%GETPDF_TRIANGULAR Probability in circular isotropic triangular kernel.
%   P = GETPDF_TRIANGULAR(POINT, MEAN, SIZE) returns the probability
%   density of the given point in an isotropic triangular kernel of given
%   radius.
%
%   POINT can also contain several points (1xM), P is then of dimension
%   1xM.
%
%   Warning: no normalization is done and this PDF therefore does NOT
%   integrate to 1.

%   Author: Damien Teney

assert(mean >= 0 && mean <= (2 * pi));
assert(radius <= pi);

% Evaluate pdf
meanVector = ones(1, size(point, 2)) * mean; % Make sure 'mean' is the same size as 'point'
assert(isequal(size(point), size(meanVector)));
distanceToMean = abs(getAngleDifference(point, meanVector));

% Fill in output vector
triangleHeight = 1 / radius;
p(1, :) = triangleHeight * ((radius - distanceToMean) / radius); % Normal case
p(1, distanceToMean >= radius) = 0; % Special case: out of the kernel
