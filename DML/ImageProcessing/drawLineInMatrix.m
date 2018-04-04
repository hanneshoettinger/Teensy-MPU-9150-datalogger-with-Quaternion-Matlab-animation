function M = drawLineInMatrix(M, point1, point2)
%DRAWLINEINMATRIX Draw line in 2D matrix.
%   M = DRAWLINEINMATRIX(M, POINT1, POINT2) draws a line in the matrix M,
%   in which the elements crossed by the line are set to '1'. All other
%   elements are left unchanged.
%
%   The coordinates of the points are given as (X, Y) pairs, NOT (I, J).

%   Author: Damien Teney

% Get coordinates of points on the line
coordinates = getRasterLineCoordinates(point1, point2);

% Rename for clarity
x = coordinates(:, 1);
y = coordinates(:, 2);

% Mark the pixels in the given matrix
for i = 1:length(x)
  if x(i) >= 1 && x(i) <= size(M, 2) ...
  && y(i) >= 1 && y(i) <= size(M, 1) % Indices in valid range
    M(y(i), x(i)) = 1;
  end
end
