function d = getPointLineDistance(points, linePoint1, linePoint2)
%GETPOINTLINEDISTANCE Distance from point to line (3D).
%   D = GETPOINTLINEDISTANCE(POINTS, LINEPOINT1, LINEPOINT2) computes
%   the shortest distance between 3D points (Nx3) and a line, defined by
%   two points (each 1x3). Returns a 1xN vector.

%   Author: Damien Teney

N = size(points, 1);

tmp1 = linePoint2 - linePoint1;
tmp2 = linePoint1(ones(1, N), :) - points;

% Do this operation on each row of the matrix:
% d(i) = norm(cross(tmp1, tmp2)) / norm(tmp1);
tmp3 = cross(tmp1(ones(1, N), :), ... % Replicate to get as many rows as in tmp2
             tmp2, ...
             2); % Cross product, row by row
d = sqrt(sum(tmp3.^2, 2)); % Norm of each row
d = d' ./ norm(tmp1);
