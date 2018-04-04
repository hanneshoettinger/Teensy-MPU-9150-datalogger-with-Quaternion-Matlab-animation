function [point1 point2] = getLinesClosestPoints(line1Point1, line1Point2, line2Point1, line2Point2)
%GETLINESCLOSESTPOINTS Closest points on 2 lines (3D; can be skew or intersecting).
%   [POINT1 POINT2] = GETLINESCLOSESTPOINT(LINE1POINT1, LINE1POINT2, LINE2POINT1, LINE2POINT2)
%   computes the closest points two skew lines, each defined by 2 points.
%   The lines can be skew or intersecting.

%   Author: Damien Teney

% See:
% http://www.faqs.org/faqs/graphics/algorithms-faq/ (5.18)
% Other possible algorithm:
% http://softsurfer.com/Archive/algorithm_0106/algorithm_0106.htm#Distance between Lines

% Rename for clarity
line1Point = line1Point1;
line2Point = line2Point1;

% Get the vectors describing the orientation of the lines
line1Dir = line1Point2 - line1Point1;
line2Dir = line2Point2 - line2Point1;

%if isAlmostEqual(line1Dir, line2Dir) || isAlmostEqual(line1Dir, -line2Dir) % Lines are near-parallel
if isequal(line1Dir, line2Dir) || isequal(line1Dir, -line2Dir) % Lines are near-parallel
  error('Parallel lines !');
end

cDir = cross(line1Dir, line2Dir); % Get the orientationt of the connecting line (perpendicular to both lines)
plane1 = getPlaneFromVectorsAnPoint(cDir, line1Dir, line1Point); % Get plane containing line 1, parallel to cDir
plane2 = getPlaneFromVectorsAnPoint(cDir, line2Dir, line2Point); % Get plane containing line 2, parallel to cDir
point1 = getLinePlaneIntersection(line1Point, line1Dir, plane2);
point2 = getLinePlaneIntersection(line2Point, line2Dir, plane1);

%==========================================================================

function plane = getPlaneFromVectorsAnPoint(v1, v2, p)
% Get a description [a b c d] for the plane of implicit equation (ax + by + cz + d = 0), containing v1, v2 and p

plane(1:3) = cross(v1, v2);
plane(1:3) = plane(1:3) ./ norm(plane(1:3));

plane(4)   = -(plane(1) * p(1) + plane(2) * p(2) + plane(3) * p(3)); % The plane contains 'p'

%==========================================================================

function intersectionPoint = getLinePlaneIntersection(linePoint, lineDirectionVector, plane)
% Intersection point between a given line and plane

linePoint1 = linePoint; % Rename for clarity
linePoint2 = linePoint + lineDirectionVector;

% Rename for clarity
dist1 = getPointPlaneDistance(linePoint1, plane);
dist2 = getPointPlaneDistance(linePoint2, plane);

denom = dist1 - dist2;
if abs(denom / (abs(dist1) + abs(dist2))) < eps
  error('No line/plane intersection !');
else
  t = dist1 / denom;
  intersectionPoint = (1 - t) * linePoint1 ...
                    + t       * linePoint2;
end

%==========================================================================

function d = getPointPlaneDistance(point, plane)
% Shortest distance from a point to a plane

d = point(1) * plane(1) ...
  + point(2) * plane(2) ...
  + point(3) * plane(3) ...
  + plane(4);
