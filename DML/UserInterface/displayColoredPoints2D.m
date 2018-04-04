function displayColoredPoints2D(points)
%DISPLAYCOLOREDPOINTS2D Plot colored 2D points.
%   DISPLAYCOLOREDPOINTS2D(POINTS) takes points in a Nx5 matrix (2D
%   position, then color in RGB format), and plot them, each in its own
%   color.

%   Author: Damien Teney

for i = 1:size(points, 1)
  plot(points(i, 1), points(i, 2), ...
    'MarkerFaceColor', [points(i, 3) points(i, 4) points(i, 5)], ...
    'MarkerEdgeColor', [0.8 0.8 0.8], ...
    'MarkerSize', 6, ...
    'Marker', 'o');
end
