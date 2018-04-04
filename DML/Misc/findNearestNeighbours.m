function [nearestNeighboursIndices nearestNeighboursSquaredDistances] = findNearestNeighbours(points, scales, queryPoints, maxDistance)
%FINDNEARESTNEIGHBOURS Linear nearest neighbour (KNN) search, with limit on the distance.
%   [NEARESTNEIGHBOURSINDICES NEARESTNEIGHBOURSSQUAREDDISTANCES] =
%   FINDNEARESTNEIGHBOURS(POINTS, SCALES, QUERYPOINTS, MAXDISTANCE) finds
%   the nearest neighbours in a set points (N x D matrix) for each of the
%   query points (M x D matrix). The results are returned in a M x k
%   matrix.
%
%   The maximum distance to the query points is given as an argument (a
%   scalar).

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

% Scale the input points
for j = 1:dimensionality % For each dimension
  points(:, j) = points(:, j) ./ scales(j);
  queryPoints(:, j) = queryPoints(:, j) ./ scales(j);
end

% Initialize output
%nearestNeighboursIndices = zeros(nQueryPoints, k); % k not known yet
%nearestNeighboursSquaredDistances = zeros(nQueryPoints, k); % k not known yet

for i = 1:nQueryPoints % For each query point
  % Measure the distance between the current query points and all the data points
  squaredDistances = zeros(nPoints, 1);
  for t = 1:dimensionality % For each dimension
    squaredDistances = squaredDistances + (points(:, t) - queryPoints(i, t)) .^ 2;
  end

  % Count how many neighbours we can keep
  neighboursToKeep = find(squaredDistances < maxDistance ^ 2);
  k = length(neighboursToKeep);

  % Sort the distances
  [sortedSquaredDistances sortedIndices] = sort(squaredDistances);

  % Copy in the output and keep only the k smallest distances
  nearestNeighboursIndices(i, 1:k) = sortedIndices(1:k);
  nearestNeighboursSquaredDistances(i, 1:k) = sortedSquaredDistances(1:k);
end
