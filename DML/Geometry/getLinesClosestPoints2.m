function [point1 point2 distance] = getLinesClosestPoints2(line1Point1, line1Point2, line2Point1, line2Point2)
%GETLINESCLOSESTPOINTS2 Closest points on 2 lines (3D; can be skew or intersecting; alternative algorithm).
%   [POINT1 POINT2] = GETLINESCLOSESTPOINT(LINE1POINT1, LINE1POINT2, LINE2POINT1, LINE2POINT2)
%   computes the closest points two skew lines, each defined by 2 points.
%   The lines can be skew or intersecting.

%   Author: Damien Teney

% See:
% http://softsurfer.com/Archive/algorithm_0106/algorithm_0106.htm#Distance between Lines

% Get the vectors describing the orientation of the lines
u = line1Point2 - line1Point1;
v = line2Point2 - line2Point1;

%w0 = line1Point 2 - line2Point2; % WRONG
w0 = line1Point1 - line2Point1; % WRONG

a = dot(u, u);
b = dot(u, v);
c = dot(v, v);
d = dot(u, w0);
e = dot(v, w0);

denom = a*c - b*b;
if denom < eps % Lines are near-parallel
  error('Near-parallel lines !');
end
sc = (b*e - c*d) / denom;
tc = (a*e - b*d) / denom;

point1 = line1Point1 + sc * u;
point2 = line2Point1 + tc * v;

%distance = norm(w0 + sc*u - tc*v); % WRONG
%distance = norm((line1Point1 - line2Point1) + (((b*e - c*d) * u - (a*e - b*d) * v) / denom)); % Correct
distance = norm(point2 - point1); % Correct too
