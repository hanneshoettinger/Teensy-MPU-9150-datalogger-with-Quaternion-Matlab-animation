function projection = projectPoint(point, P)
%PROJECTPOINT Camera projection of a 3D point.
%   PROJECTION = PROJECTPOINT(point, P) projects a point (1x3) onto the
%   image plane of a camera, specified by its projection matrix P (3x4).
%   The result is a 1x2 vector.

%   Author: Damien Teney

% Get the point in homogeneous coordinates
pointHomogeneous = [point 1]; % 1x4 vector

projectionHomogeneous = P * pointHomogeneous';

projection = zeros(1, 2);
projection(1) = projectionHomogeneous(1) / projectionHomogeneous(3);
projection(2) = projectionHomogeneous(2) / projectionHomogeneous(3);
