function coordinates = getRasterLineCoordinates(point1, point2)
%GETRASTERLINECOORDINATES Coordinates of raster line.
%   COORDINATES = GETRASTERLINECOORDINATES(POINT1, POINT2) returns the 2D
%   coordinates (Nx2) of the points of the rasterized 2D line between
%   POINT1 and POINT2.
%
%   The coordinates of the points are given as (X, Y) pairs, NOT (I, J).

%   Author: original code by  Chandan Kumar, modified by Damien Teney
%   http://www.mathworks.com/matlabcentral/fileexchange/25524

% Rename for clarity
x0 = point1(1); y0 = point1(2);
x1 = point2(1); y1 = point2(2);

dx = abs(x1 - x0);
dy = abs(y1 - y0);
sx = sign(x1 - x0);
sy = sign(y1 - y0);

if (dy > dx)
  step = dy;
else 
  step = dx;
end

x(1) = x0; y(1) = y0;
j = 1;
for i = 0:1:step
  if (x1 == x(j)) && (y1 == y(j))
    break;
  end
  j = j+1;
  x(j) = x(j - 1) + (dx / step) * sx;
  y(j) = y(j - 1) + (dy / step) * sy;
end

x = round(x);
y = round(y);

coordinates(:, 1:2) = [x' y'];
