function edgePoints = extractEdgePoints(edgeMap, minimumDistanceBetweenNeighbours)
%EXTRACTEDGEPOINTS Extraction of points along edges in image.
%   EDGEPOINTS = EXTRACTEDGEPOINTS(EDGEMAP, MINIMUMDISTANCEBETWEENNEIGHBOURS)
%   extracts oriented points along edges in the given edge map (MxN; 1 for
%   edge, 0 otherwise; edges should be thinned out already).
%
%   The algorithm ensures that the returned points are all separated by a
%   (given) minimum distance.
%
%   Returns a Px3 matrix (position (2), orientation (1) in radians
%   [-pi/2,pi/2]).

%   Author: Damien Teney

%--------------------------------------------------------------------------
% Get indices of pixels belonging to edges
%--------------------------------------------------------------------------
[tmpI tmpJ] = find(edgeMap); % Get indices of points falling on edges
edgePoints_all = [tmpJ tmpI]; % X/Y (not i/j !!!) coordinates
nPointsTotal = size(edgePoints_all, 1);

%--------------------------------------------------------------------------
% Keep a subset of the points
% Method 1: random subsampling
%--------------------------------------------------------------------------
%{
% Decide how many points to keep
%maxEdgePoints = 1000;
maxEdgePoints = floor(nPointsTotal * 0.33);
%maxEdgePoints = ceil(nPointsTotal * 0.5);

% Effectively keep only a fraction of the points
edgePoints = removeMatrixRows(edgePoints_all, maxEdgePoints);
%}

%--------------------------------------------------------------------------
% Keep a subset of the points
% Method 2: keep a minimum distance between them
%--------------------------------------------------------------------------
%{
if nargin < 2
  minimumDistanceBetweenNeighbours = 2.5; % Set a default value
end
% Initialization
pointsToConsider = true(1, nPointsTotal); % All points are potential ones to keep
pointsToKeep     = false(1, nPointsTotal); % We don't keep any, initially

while true
  % Starting at that random index, look for a point that is yet to consider
  randomStartingPoint = getRandomInteger_uniform(1, nPointsTotal); % Start at a random index
  pointToKeepIndex = -1;
  for i = 1:nPointsTotal % For all points in edgePoints_all/pointsToConsider
    realIndex = mod((randomStartingPoint - 1) + (i - 1), nPointsTotal) + 1;

    if pointsToConsider(realIndex) == true % We found a point that is still candidate for being kept
      pointToKeepIndex = realIndex;
      break;
    end
  end
  if pointToKeepIndex < 0 % There are no points anymore to consider
    break;
  end

  pointsToConsider(pointToKeepIndex) = false; % Mark the chosen point as not to consider anymore
  pointsToKeep(pointToKeepIndex) = true; % Mark the chosen point as "to keep"

  % Discard all the close neighbours to that point
  [nearestNeighboursIndices trash] = findNearestNeighbours(edgePoints_all(:, 1:2), [], edgePoints_all(pointToKeepIndex, 1:2), minimumDistanceBetweenNeighbours); % Max distance specified
  pointsToConsider(nearestNeighboursIndices) = false; % Mark the neighbours as points that don't have to be considered
  %{
  % Debug display
  displayEmpty2DFigure();
  for i = 1:length(nearestNeighboursIndices)
    plot(edgePoints_all(nearestNeighboursIndices(i), 1), edgePoints_all(nearestNeighboursIndices(i), 2), 'bx');
  end
  plot(edgePoints_all(pointsToConsider, 1), edgePoints_all(pointsToConsider, 2), 'k.');
  plot(edgePoints_all(pointToKeepIndex, 1), edgePoints_all(pointToKeepIndex, 2), 'go');
  pause
  %}
end

% Effectively keep only the points marked as such
edgePoints = edgePoints_all(pointsToKeep, :);
%}

%--------------------------------------------------------------------------
% Keep a subset of the points
% Method 2b: keep a minimum distance between them (different algorithm: go on with the closest point to the last one kept)
%--------------------------------------------------------------------------
%%{
if nargin < 2
  minimumDistanceBetweenNeighbours = 2.5; % Set a default value
end
% Initialization
indicesToConsider = true(1, nPointsTotal); % All points are potential ones to keep
indicesToKeep     = false(1, nPointsTotal); % We don't keep any, initially

currentIndex = getRandomInteger_uniform(1, nPointsTotal); % Start at a random index

while true
  indicesToConsider(currentIndex) = false; % Mark the current point as not to consider anymore
  indicesToKeep(currentIndex) = true; % Mark the current point as "to keep"

  % Discard all the close neighbours to that point
  [nearestNeighboursIndices trash] = findNearestNeighbours(edgePoints_all(:, 1:2), [], edgePoints_all(currentIndex, 1:2), minimumDistanceBetweenNeighbours); % Max distance specified
  indicesToConsider(nearestNeighboursIndices) = false; % Mark the neighbours as points that don't have to be considered
  %{
  % Debug display
  displayEmpty2DFigure();
  for i = 1:length(nearestNeighboursIndices)
    plot(edgePoints_all(nearestNeighboursIndices(i), 1), edgePoints_all(nearestNeighboursIndices(i), 2), 'bx');
  end
  plot(edgePoints_all(indicesToConsider, 1), edgePoints_all(indicesToConsider, 2), 'k.');
  plot(edgePoints_all(currentIndex, 1), edgePoints_all(currentIndex, 2), 'go');
  pause
  %}

  % Find the next point (closest one that is yet to consider)
  tmp = edgePoints_all(indicesToConsider, 1:2);
  if size(tmp, 1) < 1 % There are no points anymore to consider
    break;
  end
  distances(indicesToConsider) = getNormOfRows(tmp - repmat(edgePoints_all(currentIndex, 1:2), size(tmp, 1), 1));
  distances(~indicesToConsider) = +inf;
  [trash closestPointIndex] = min(distances);
  currentIndex = closestPointIndex;
end

% Effectively keep only the points marked as such
edgePoints = edgePoints_all(indicesToKeep, :);
%}

%--------------------------------------------------------------------------
% Get an orientation for each point
% Method 1: main orientation of the cloud of points centered on each considered point)
%--------------------------------------------------------------------------
%%{
eigenValueMagnitudes = zeros(1, size(edgePoints, 1));
for i = 1:size(edgePoints, 1)
  % Find a few close neighbours
  %[nearestNeighboursIndices trash] = findKNearestNeighbours(edgePoints_all(:, 1:2), [], edgePoints(i, 1:2), 30); % Number of neighbours specified
  [nearestNeighboursIndices trash] = findNearestNeighbours(edgePoints_all(:, 1:2), [], edgePoints(i, 1:2), 5); % Max distance specified
  nearestNeighbours = edgePoints_all(nearestNeighboursIndices, 1:2);

  % Get the main orientation of the group of neighbours
  if size(nearestNeighbours, 1) > 1 % Only possible if we have several close neigbours
    covariance = cov(nearestNeighbours(:, 1:2));
    [eigenVectors eigenValues] = eig(covariance);
    if eigenValues(1, 1) > eigenValues(2, 2)
      eigenValueMagnitudes(i) = sqrt(eigenValues(1, 1));
      orientationVector = eigenVectors(:, 1);
    else
      eigenValueMagnitudes(i) = sqrt(eigenValues(2, 2));
      orientationVector = eigenVectors(:, 2);
    end

    % Get the orientation as an angle
    orientationAngle = getOrientationFrom2DPoints([0 0], orientationVector);

    edgePoints(i, 3) = orientationAngle;
  end

  % "Smooth" the edges by adjusting the position of the edge point
  edgePoints(i, 1:2) = mean(nearestNeighbours(:, 1:2), 1);
end
% Keep only edge points with non-ambiguous orientations
%figure(); hist(eigenValueMagnitudes); % Debug display
edgePoints = edgePoints(eigenValueMagnitudes >= 2.5, :);
%}

%--------------------------------------------------------------------------
% Get an orientation for each point
% Method 2: orientation of the vector between the considered point and a single other neighbour)
%--------------------------------------------------------------------------
%{
for i = 1:size(edgePoints, 1)
  % Follow close neighbours one after another
  startPoint   = edgePoints(i, 1:2);
  currentPoint = edgePoints(i, 1:2);
  for j = 1:10 % For each neighbour to follow
    % Define where to look for the next point
    if isequal(j, 1) % First iteration
      nextPointProbablePosition = currentPoint;
    else % Other iterations
      nextPointProbablePosition = currentPoint + (currentPoint - startPoint) / (j - 1);
    end

    % Find one (close) neighbour to that position
    [nearestNeighboursIndices trash] = findNearestNeighbours(edgePoints_all(:, 1:2), [], nextPointProbablePosition, norm([2 1])); % Get closest neighbours with limit on distance
    if length(nearestNeighboursIndices) < 2 % No neighbours found in the preset radius
      break; % Early stop
    end
    closeNeighbour = edgePoints_all(nearestNeighboursIndices(2), 1:2);

    % Keep that point
    currentPoint = closeNeighbour;
  end

  % Get the main orientation of the pair startPoint/currentPoint
  orientationAngle = getOrientationFrom2DPoints(closeNeighbour(1, 1:2), ...
                                                edgePoints(i, 1:2));
  edgePoints(i, 3) = orientationAngle; % Save the value
end
%}
