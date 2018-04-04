function edgeMap = removeEdgeLines(edgeMap)
%REMOVEEDGELINES Detection/deletion of lines in edge map.
%   EDGEMAP = REMOVEEDGELINES(EDGEMAP) detects the straight lines in a
%   given edge map (binary image) and removes them.

%   Author: Damien Teney

minLength = 40;

% Find lines
[H T R] = hough(edgeMap);
P = houghpeaks(H, 100, 'threshold', 0.3 * max(H(:)));
lines = houghlines(edgeMap, T, R, P, 'FillGap', 5, 'MinLength', minLength);

% Creat a mask with the detected lines
edgeMapMask = true(size(edgeMap));
%figure(); imshow(edgeMap); hold on; % Debug display

nLines = length(lines);
if nLines < 2 % houghlines() buggy with less than 2 lines found (never returns an empty result when it should)
  return;
end
for k = 1:nLines
  linePoints = [lines(k).point1; lines(k).point2];

  % Keep the ends of the line
  %%{
  lineVector = linePoints(2, :) - linePoints(1, :);
  lineVector = lineVector ./ norm(lineVector); % Normalize
  linePoints(1, :) = linePoints(1, :) + lineVector * 10;
  linePoints(2, :) = linePoints(2, :) - lineVector * 10;
  %}

  %plot(linePoints(:, 1), linePoints(:, 2), '+-'); % Debug display

  xPoints = linspace(linePoints(1, 1), linePoints(2, 1), 1000); % Set of points along the line
  yPoints = linspace(linePoints(1, 2), linePoints(2, 2), 1000);
  indices = sub2ind(size(edgeMap), round(yPoints), round(xPoints)); % Get linear indices
  edgeMapMask(indices) = false;
end

edgeMapMask = ~imdilate(~edgeMapMask, strel('disk', 4)); % Make the lines thicker
edgeMap = edgeMap & edgeMapMask; % Apply the mask
