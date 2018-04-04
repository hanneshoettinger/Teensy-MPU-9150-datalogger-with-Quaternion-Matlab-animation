function radius = getPointCloudRadius(points)
%GETPOINTCLOUDRADIUS Radius of 3D point cloud.
%   RADIUS = GETPOINTCLOUDRADIUS(POINTS) takes a cloud of 3D points (Nx3
%   matrix), and determine its approximate radius.

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

% Method 1 (median distance to the center)
%s = median(distances);

% Method 2 (keep the radius that encompasses 85% of the points)
distances = sort(distances);
index = ceil(0.85 * length(distances));
radius = distances(index);
