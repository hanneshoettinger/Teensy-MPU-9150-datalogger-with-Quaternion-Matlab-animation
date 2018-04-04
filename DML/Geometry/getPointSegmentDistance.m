function d = getPointSegmentDistance(point, segmentPoint1, segmentPoint2)
%GETPOINTSEGMENTDISTANCE Distance from point to line segment (3D).
%   D = GETPOINTSEGMENTDISTANCE(POINT, SEGMENTPOINT1, SEGMENTPOINT2)
%   computes the shortest distance between a 3D point (1x3) and a line
%   segment, defined by two points (each 1x3).
%
%   WARNING (special behaviour): if the projection of the point on the line
%   of the segment falls outside the defined segment, a distance of +inf is
%   returned.

%   Author: Damien Teney

% Version 1
%{
tmp1 = segmentPoint2 - segmentPoint1;
tmp2 = segmentPoint1 - point;
dotProduct = dot(-tmp2, tmp1 / norm(tmp1));
if dotProduct < 0 || dotProduct > norm(tmp1) % Closest point on segment is outside of the segment
  d = +inf;
else
  d = norm(cross(tmp1, tmp2)) / norm(tmp1);
  % Intersection at
  % projectedPoint = segmentPoint1 + (tmp1 / norm(tmp1)) * dotProduct;
end
%}

% Version 2 (faster)
% Reference:
% http://people.sc.fsu.edu/~jburkardt/m_src/geometry/segment_point_dist_3d.m
%%{
bot = sum((segmentPoint2 - segmentPoint1).^2);
t = (point(:) - segmentPoint1(:))' * (segmentPoint2(:) - segmentPoint1(:)) / bot;

% Make sure t is in [0, 1]
t = max (t, 0.0);
t = min (t, 1.0);

projection = segmentPoint1 + t * (segmentPoint2 - segmentPoint1);
d = sqrt(sum((projection - point).^2));
%}
