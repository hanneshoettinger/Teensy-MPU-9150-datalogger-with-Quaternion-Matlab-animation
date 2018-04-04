function displayColoredPoints3D(points)
%DISPLAYCOLOREDPOINTS3D Plot colored 3D points.
%   DISPLAYCOLOREDPOINTS3D(POINTS) takes points in a Nx6 matrix (3D
%   position, then color in RGB format), and plot them, each in its own
%   color.

%   Author: Damien Teney

for i = 1:size(points, 1)
  plot3(points(i, 1), points(i, 2), points(i, 3), ...
    'MarkerFaceColor', [points(i, 4) points(i, 5) points(i, 6)], ...
    'MarkerEdgeColor', [0.8 0.8 0.8], ...
    'MarkerSize', 8, ...
    'Marker', 'o');
end
