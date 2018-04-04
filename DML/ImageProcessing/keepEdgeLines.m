function edgeMap = keepEdgeLines(edgeMap)
%KEEPEDGELINES Detection/selection of lines in edge map.
%   EDGEMAP = KEEPEDGELINES(EDGEMAP) detects the straight lines in a
%   given edge map (binary image) and removes everything than doesn't
%   belong to one.

%   Author: Damien Teney

%%{
% Method 1: with Matlab's functions

% Find lines
[H T R] = hough(edgeMap);
P = houghpeaks(H, 1000, 'threshold', 0.1 * max(H(:)));
lines = houghlines(edgeMap, T, R, P, 'FillGap', 3, 'MinLength', 20);

% Create a mask with the detected lines
edgeMapMask = true(size(edgeMap));
%figure(); imshow(edgeMap); hold on; % Debug display
nLines = length(lines);
if nLines < 2 % houghlines() buggy with less than 2 lines found (never returns an empty result when it should)
  return;
end
for k = 1:nLines
  linePoints = [lines(k).point1; lines(k).point2];

  %plot(linePoints(:, 1), linePoints(:, 2), '+-'); % Debug display

  xPoints = linspace(linePoints(1, 1), linePoints(2, 1), 1000); % Set of points along the line
  yPoints = linspace(linePoints(1, 2), linePoints(2, 2), 1000);
  indices = sub2ind(size(edgeMap), round(yPoints), round(xPoints)); % Get linear indices
  edgeMapMask(indices) = false;
end

edgeMapMask = imdilate(~edgeMapMask, strel('disk', 2)); % Make the lines thicker
edgeMap = edgeMap & edgeMapMask; % Apply the mask
%}

%{
% Method 2: with Kovesi's functions

% Link edge pixels together into lists of sequential edge points, one list for each edge contour
[edgelist labeledEdgeMap] = edgelink(edgeMap, 14);

% Fit line segments to the edgelists
segments = lineseg(edgelist, 1); % Maximum deviation from original edge of 2 pixels

% Create a mask with the detected lines
edgeMapMask = true(size(edgeMap));
%figure(); imshow(edgeMap); hold on; % Debug display
for i = 1:numel(segments)
  for j = 1:(size(segments{i}, 1) - 1)
    linePoints = segments{i}([j j + 1], [2 1]);
    lineLength = norm(linePoints(2, :) - linePoints(1, :));
    if lineLength < 14
      continue;
    end

    %plot(linePoints(:, 1), linePoints(:, 2), '+-'); % Debug display

    xPoints = linspace(linePoints(1, 1), linePoints(2, 1), 1000); % Set of points along the line
    yPoints = linspace(linePoints(1, 2), linePoints(2, 2), 1000);
    indices = sub2ind(size(edgeMap), round(yPoints), round(xPoints)); % Get linear indices
    edgeMapMask(indices) = false;
  end
end

edgeMapMask = imdilate(~edgeMapMask, strel('disk', 3)); % Make the lines thicker
edgeMap = edgeMap & edgeMapMask; % Apply the mask
%}
