function centerOfGravity = getPointCloudCenterOfGravity(points)
%GETPOINTCLOUDCENTEROFGRAVITY Center of gravity of 3D point cloud.
%   CENTEROFGRAVITY = GETPOINTCLOUDCENTEROFGRAVITY(POINTS) takes a cloud
%   of 3D points (Nx3 matrix), and finds its center of gravity. The
%   returned point CENTEROFGRAVITY is of size (1x3).

%   Author: Damien Teney

nPoints = size(points, 1);
centerOfGravity = zeros(1, 3);

centerOfGravity(1, 1) = sum(points(:, 1)) / nPoints;
centerOfGravity(1, 2) = sum(points(:, 2)) / nPoints;
centerOfGravity(1, 3) = sum(points(:, 3)) / nPoints;
