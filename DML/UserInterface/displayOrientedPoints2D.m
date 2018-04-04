function displayOrientedPoints2D(points, markerStyle, markerSize, colors)
%DISPLAYORIENTEDPOINTS2D Plot oriented 2D points.
%   DISPLAYORIENTEDPOINTS2D(POINTS, MARKERSTYLE, LINELENGTH, COLORS) plots
%   2D points together with their orientation.
%
%   POINTS is a Nx3 matrix: position (2), orientation angle in radians (1)
%   MARKERSTYLE can be 'points', 'hollowPoints', 'bars', or 'tees'
%   MARKERSIZE is the length of the markers displayed
%   COLORS is an optional Nx3 matrix, containing a RGB color for each point

%   Author: Damien Teney

color = getColor(0);

switch markerStyle
  %------------------------------------------------------------------------
  case 'points'
    for i = 1:size(points, 1)
      % Get the color
      if nargin < 4
        color = getColor(0);
      else
        color = colors(i, 1:3);
      end

      plot(points(i, 1), points(i, 2), ...
        'MarkerSize', markerSize, ...
        'MarkerEdgeColor', color, ...
        'MarkerFaceColor', color, ...
        'Marker', 'o');
    end
  %------------------------------------------------------------------------
  case 'hollowPoints'
    for i = 1:size(points, 1)
      % Get the color
      if nargin < 4
        color = getColor(0);
      else
        color = colors(i, 1:3);
      end

      plot(points(i, 1), points(i, 2), ...
        'MarkerSize', markerSize, ...
        'MarkerEdgeColor', [.7 .7 .7], ...
        'MarkerFaceColor', color, ...
        'Marker', 'o');
    end
  %------------------------------------------------------------------------
  case 'bars'
    for i = 1:size(points, 1)
      % Get the color
      if nargin < 4
        color = getColor(0);
      else
        color = colors(i, 1:3);
      end

      % Rename for clarity
      point = points(i, 1:2);
      orientation = points(i, 3); % Orientation (angle in radians)

      lineStart = point - markerSize * [cos(orientation) sin(orientation)];
      lineEnd = point + markerSize * [cos(orientation) sin(orientation)];

      plot([lineStart(1) lineEnd(1)], ...
           [lineStart(2) lineEnd(2)], ...
           'Color', color, ...
           'Marker', 'none', ...
           'LineStyle', '-', ...
           'LineWidth', 1.2);
    end
  %------------------------------------------------------------------------
  case 'tees'
    for i = 1:size(points, 1)
      % Get the color
      if nargin < 4
        color = getColor(0);
      else
        color = colors(i, 1:3);
      end

      % Rename for clarity
      point = points(i, 1:2);
      orientation = points(i, 3); % Orientation (angle in radians)

      lineStart = point - markerSize * [cos(orientation) sin(orientation)];
      lineEnd = point + markerSize * [cos(orientation) sin(orientation)];

      plot([lineStart(1) lineEnd(1)], ...
           [lineStart(2) lineEnd(2)], ...
           'Color', color, ...
           'Marker', 'none', ...
           'LineStyle', '-', ...
           'LineWidth', 1.2);

      % Add the "bottom" of the T to show the direction of the point (the orientation is not modulo pi, but (2 * pi))
      % Rename for clarity
      point = points(i, 1:2);
      orientation = points(i, 3); % Orientation (angle in radians)

      lineStart = point;
      lineEnd = point + 0.75 * markerSize * [cos(orientation + pi/2) sin(orientation + pi/2)];

      plot([lineStart(1) lineEnd(1)], ...
           [lineStart(2) lineEnd(2)], ...
           'Color', color, ...
           'Marker', 'none', ...
           'LineStyle', '-', ...
           'LineWidth', 1.2);
    end
  %------------------------------------------------------------------------
  otherwise
    error('Unknown markerStyle.');
  %------------------------------------------------------------------------
end
