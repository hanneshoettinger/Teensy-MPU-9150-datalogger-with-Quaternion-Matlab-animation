function pointIndices = getCentralPointsInPointCloud(points)
% GETCENTRALPOINTSINPOINTCLOUD Identify central points in 3D point cloud.
%   POINTINDICES = GETCENTRALPOINTSINPOINTCLOUD(POINTS) takes a cloud of
%   3D points (Nx3 matrix), finds its center of gravity, and identify the
%   points that are close enough to this center. The (row) indices of these
%   points in the input matrix are returned.

%   Author: Damien Teney

nPoints = size(points, 1);

% Get the center of gravity
centerOfGravity = getPointCloudCenterOfGravity(points);
assert(isequal(size(centerOfGravity), [1 3]));

% Get the distance of each point to the center of gravity
distances = zeros(nPoints, 1);
for i = 1:nPoints % For each point in the point cloud
  distances(i) = norm(points(i, :) - centerOfGravity);
end

% Define a threshold
distanceThreshold = min(2 * median(distances), ...
                        0.9 * max(distances));

% Get the indexes of points below the threshold
pointIndices = find(distances < distanceThreshold);
