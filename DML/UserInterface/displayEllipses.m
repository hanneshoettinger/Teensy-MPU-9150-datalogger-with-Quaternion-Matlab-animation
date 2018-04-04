function displayEllipses(centers, radiuses, orientationAngles, colors)
%DISPLAYELLIPSES Display 2D ellipses.
%   DISPLAYELLIPSES(CENTERS, RADIUSES, ORIENTATIONANGLES, COLORS) displays
%   ellipses of given centers (Nx2), major/minor radiuses (Nx2),
%   orientation angles (1xN, in radians) and colors (optional Nx3 matrix of
%   RGB values).

%   Author: Damien Teney

% Constants
color = [0 0 0];
transparency = 0.2;

for i = 1:size(centers, 1)
  center(1:2)      = centers(i, 1:2);
  width            = radiuses(i, 1);
  height           = radiuses(i, 2);
  orientationAngle = orientationAngles(i);
  orientationAngle = -orientationAngle; % Convention we chose
  if nargin >= 4
    color = colors(i, 1:3);
    transparency = 1.0;
  end

  % Plot an ellipse
  tmp = 0 : 0.1 : (2 * pi) + 0.1;
  p = [(width * cos(tmp))' (height * sin(tmp))'];
  R = [cos(orientationAngle) -sin(orientationAngle)
       sin(orientationAngle) cos(orientationAngle)];
  p = p * R;
  patch(center(1) + p(:, 1), ...
        center(2) + p(:, 2), ...
        color, ...
        'LineStyle', '-', ...
        'LineWidth', 0.5, ...
        'EdgeColor', 0.8 * color, ...
        'FaceAlpha', transparency);
        %'LineStyle', 'none', ...
end
