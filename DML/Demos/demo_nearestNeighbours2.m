function demo_nearestNeighbours2()
%DEMO_NEARESTNEIGHBOURS2 Demo of nearest neighbours (specified limit on the distance).

% Generate data
dataPoints = rand(100, 2);
queryPoints = [0 0];

% Get the nearest neighbours
maxDistance = 0.5
indices = findNearestNeighbours(dataPoints, [], queryPoints, maxDistance);

% Display the results
figure();
theta = 0:0.01:pi/2;
x = maxDistance * cos(theta);
y = maxDistance * sin(theta);
plot(dataPoints(:,1), dataPoints(:,2), 'b.', ...
     queryPoints(:,1), queryPoints(:,2), 'bo', ...
     dataPoints(indices,1), dataPoints(indices,2), 'go', ...
     x, y, 'r-');

nNeighbours = length(indices)
