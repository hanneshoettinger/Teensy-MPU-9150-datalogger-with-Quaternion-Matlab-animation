function displayOrientedPoints3D(points, markerStyle, markerSize, colors)
%DISPLAYORIENTEDPOINTS3D Plot oriented 3D points.
%   DISPLAYORIENTEDPOINTS3D(POINTS, MARKERSTYLE, MARKERSIZE, COLORS) plots
%   3D points together with their orientation.
%
%   POINTS is a Nx6 matrix: position (3), orientation 3-vector (3)
%   MARKERSTYLE can be 'points', 'hollowPoints', or 'bars'
%   MARKERSIZE is the length of the markers displayed
%   COLORS is an optional Nx3 matrix, containing a RGB color for each point

%   Author: Damien Teney

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

      plot3(points(i, 1), points(i, 2), points(i, 3), ...
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

      plot3(points(i, 1), points(i, 2), points(i, 3), ...
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
      point = points(i, 1:3);
      orientation = points(i, 4:6); % Orientation (3-vector)

      % Get both ends of the line segment to display
      lineStart = point - markerSize * orientation;
      lineEnd = point + markerSize * orientation;
      plot3([lineStart(1) lineEnd(1)], ...
            [lineStart(2) lineEnd(2)], ...
            [lineStart(3) lineEnd(3)], ...
           'Color', color, ...
           'Marker', 'none', ...
           'LineStyle', '-', ...
           'LineWidth', 1.1);
    end
  %------------------------------------------------------------------------
  otherwise
    error('Unknown markerStyle.');
  %------------------------------------------------------------------------
end
