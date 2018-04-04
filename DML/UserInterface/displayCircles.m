function displayCircles(centers, radiuses, colors)
%DISPLAYCIRCLES Display 2D circles.
%   DISPLAYCIRCLES(CENTERS, RADIUSES, COLORS) displays circles of given
%   centers (Nx2 matrix), radiuses (1xN vector) and colors (optional Nx3
%   matrix of RGB values).

%   Author: Damien Teney

% Constants
resolution = 8;
color = [0 0 0];
transparency = 0.2;

for i = 1:size(centers, 1)
  center = centers(i, :);
  radius = radiuses(i);
  if nargin >= 3
    color = colors(i, 1:3);
    transparency = 0.0;
  end

  % Plot a circle
  [x y z] = cylinder(radius, resolution);
  x = x + center(1);
  y = y + center(2);
  fill(x(1, :), y(1, :), ...
       color, ...
       'LineStyle', 'none', ...
       'FaceAlpha', transparency);
end
