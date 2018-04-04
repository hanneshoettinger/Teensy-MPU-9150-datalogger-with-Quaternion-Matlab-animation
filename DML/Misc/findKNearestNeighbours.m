function [nearestNeighboursIndices nearestNeighboursSquaredDistances] = findKNearestNeighbours(points, scales, queryPoints, k)
%FINDKNEARESTNEIGHBOURS Linear k-nearest neighbour (KNN) search.
%   [NEARESTNEIGHBOURSINDICES NEARESTNEIGHBOURSSQUAREDDISTANCES] =
%   FINDNEARESTNEIGHBOURS(POINTS, SCALES, QUERYPOINTS, K) finds
%   the K nearest neighbours in a set points (N x D matrix) for each of the
%   query points (M x D matrix). The results are returned in a M x K
%   matrix.

%   Author: Yi Cao
%   (http://www.mathworks.com/matlabcentral/fileexchange/19345), modified
%   by Damien Teney

if isempty(scales) % No scale given
  scales = ones(1, size(points, 2)); % Default value
end

% Check dimensions of input
assert(isequal(size(points, 2), size(queryPoints, 2)));
assert(isequal(size(points, 2), numel(scales)));

% Get dimensions of input
nQueryPoints = size(queryPoints, 1);
nPoints = size(points, 1);
dimensionality = size(queryPoints, 2);

k = min(k, nPoints); % Avoid over-indexing if k > nPoints

% Scale the input points
for j = 1:dimensionality % For each dimension
  points(:, j) = points(:, j) ./ scales(j);
  queryPoints(:, j) = queryPoints(:, j) ./ scales(j);
end

% Initialize output
nearestNeighboursIndices = zeros(nQueryPoints, k);
nearestNeighboursSquaredDistances = zeros(nQueryPoints, k);

for i = 1:nQueryPoints % For each query point
  % Measure the distance between the current query points and all the data points
  squaredDistances = zeros(nPoints, 1);
  for t = 1:dimensionality % For each dimension
    squaredDistances = squaredDistances + (points(:, t) - queryPoints(i, t)) .^ 2;
  end

  % Sort the distances
  [sortedSquaredDistances sortedIndices] = sort(squaredDistances);

  % Copy in the output and keep only the k smallest distances
  nearestNeighboursIndices(i, 1:k) = sortedIndices(1:k);
  nearestNeighboursSquaredDistances(i, 1:k) = sortedSquaredDistances(1:k);
end
