function points = getCirclePoints(nPoints)
%GETCIRCLEPOINTS Equally spaced 2D points on a circle.
%   POINTS = GETCIRCLEPOINTS(NPOINTS) generates a given number of 2D points
%   on a circle of unit radius. The points are returned in a Nx2 matrix
%   with their X and Y coordinates.

%   Author: Damien Teney

points = zeros(nPoints, 2);

angleStep = (2 * pi) / 18;
currentAngle = 0;

for i = 1:nPoints % For each point to generate
  points(i, 1) = cos(currentAngle);
  points(i, 2) = sin(currentAngle);
  currentAngle = currentAngle + angleStep;
end

% Debug display
%figure(); hold on; plot(points(:, 1), points(:, 2), '.')
