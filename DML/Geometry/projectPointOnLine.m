function point2 = projectPointOnLine(point, linePoint1, linePoint2)
%PROJECTPOINTONLINE Project point on line.
%   POINT2 = PROJECTPOINTONLINE(POINTS, LINEPOINT1, LINEPOINT2) computes
%   the 3D point POINT2, the closest from POINT, lying on the line defined
%   by two other points (each 1x3).

%   Author: Damien Teney

 % Get a unit vector on the line
v = linePoint2 - linePoint1;
v = v / norm(v);

u = point - linePoint1;

point2 = linePoint1 + dot(u, v) * v;
