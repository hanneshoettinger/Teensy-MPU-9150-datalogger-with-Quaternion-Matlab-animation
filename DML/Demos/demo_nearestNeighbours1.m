function demo_nearestNeighbours1()
%DEMO_NEARESTNEIGHBOURS1 Demo of nearest neighbours (specified number of neighbours).

% Generate data
dataPoints = rand(100, 2);
queryPoints = [0 0];

% Get the nearest neighbours
indices = findKNearestNeighbours(dataPoints, [], queryPoints, 10);

% Display the results
figure();
r = max(sqrt(sum(dataPoints(indices, :) .^2, 2)));
theta = 0:0.01:pi/2;
x = r * cos(theta);
y = r * sin(theta);
plot(dataPoints(:,1), dataPoints(:,2), 'b.', ...
     queryPoints(:,1), queryPoints(:,2), 'bo', ...
     dataPoints(indices,1), dataPoints(indices,2), 'go', ...
     x, y, 'r-');
