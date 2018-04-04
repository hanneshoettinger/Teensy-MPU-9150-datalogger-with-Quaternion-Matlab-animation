function point = getRandomPointOnLine(startPoint, endPoint)
%GETRANDOMPOINTONLINE Random point on a line segment (2D or 3D).
%   POINT = GETRANDOMPOINTONLINE(STARTPOINT, ENDPOINT) returns a random
%    point on a line segment defined by its start and end points (1x2 or
%    1x3 vectors).

%   Author: Damien Teney

direction = endPoint - startPoint;
point = startPoint + direction * rand(1);
