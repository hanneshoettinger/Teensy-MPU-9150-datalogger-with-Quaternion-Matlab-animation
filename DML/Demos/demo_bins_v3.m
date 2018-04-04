function demo_bins_v3
%DEMO_BINS_V3 Demo of the partitioning of the 2-sphere (unit 3-vectors).

resolution = 2;
nBins = v3_getBinCount(resolution)

%--------------------------------------------------------------------------
% Shows points and the bins they fall into
%--------------------------------------------------------------------------
figure(); axis([-1 1 -1 1 -1 1]); axis equal vis3d; hold on; % Empty figure
displaySpheres([0 0 0], 1); % Unit sphere around the origin
for i = 1:10
  % Get a random point and display it
  v = v3_getRandom();
  plot3(v(1), v(2), v(3), 'b.');

  % Get its ID
  binIndex = v3_getBinIndex(v, resolution);

  % Display the border of the bin
  [corner0 corner1 corner2] = v3_getBinLimits(binIndex, resolution);
  plot3([corner0(1) ; corner1(1) ; corner2(1); corner0(1)], ...
        [corner0(2) ; corner1(2) ; corner2(2); corner0(2)], ...
        [corner0(3) ; corner1(3) ; corner2(3); corner0(3)], ...
        'k-');

  % Display the center of the bin
  binCenter = v3_getBinCenter(binIndex, resolution);
  plot3([binCenter(1) ; v(1)], ...
        [binCenter(2) ; v(2)], ...
        [binCenter(3) ; v(3)], ...
        'k-');
  plot3(binCenter(1), binCenter(2), binCenter(3), 'r.');
end

%--------------------------------------------------------------------------
% Display all bins
%--------------------------------------------------------------------------
figure(); axis([-1 1 -1 1 -1 1]); axis equal vis3d; hold on; % Empty figure
for binIndex = 0:(v3_getBinCount(resolution) - 1)
  [corner0 corner1 corner2] = v3_getBinLimits(binIndex, resolution);
  binCenter = v3_getBinCenter(binIndex, resolution);

  % Display the bin
  plot3([corner0(1) ; corner1(1) ; corner2(1); corner0(1)], ...
        [corner0(2) ; corner1(2) ; corner2(2); corner0(2)], ...
        [corner0(3) ; corner1(3) ; corner2(3); corner0(3)], ...
        'k-');
  plot3(binCenter(1), binCenter(2), binCenter(3), 'r.');
end

%--------------------------------------------------------------------------
% Show that the bin indices are linearly distributed
%--------------------------------------------------------------------------
nIterations = 5000;
indices = zeros(1, nIterations);
for i = 1:nIterations
  v = v3_getRandom();
  indices(i) = v3_getBinIndex(v, resolution);
end

% Show that the indices are linearly distributed
figure(); hist(double(indices), v3_getBinCount(resolution) / 2);

%--------------------------------------------------------------------------
% Generate evenly distributed points
%--------------------------------------------------------------------------
resolution = 2;
points = v3_getUniformGrid(resolution);
nPoints = size(points, 1)

% Display the points
figure(); axis([-1 1 -1 1 -1 1]); axis equal vis3d; hold on; % Empty figure
displaySpheres([0 0 0], 1); % Unit sphere around the origin
plot3(points(:, 1), points(:, 2), points(:, 3), 'b.');

% Measure the uniformity of the grid
nTests = 10000;
smallestAngles = zeros(1, nTests);
for i = 1:nTests
  % Generate a point
  point = v3_getRandom();

  % Get the distance from the point to the closest point of the grid
  smallestAngle = +inf;
  for k = 1:size(points, 1) % For each point of the grid
    angle = v3_getAngleBetweenVectors(point, points(k, 1:3));
    smallestAngle = min(smallestAngle, angle);
  end

  smallestAngles(i) = smallestAngle;
end
figure(); hist(rad2deg(smallestAngles), 30);
rad2deg(mean(smallestAngles)) % Mean distance
