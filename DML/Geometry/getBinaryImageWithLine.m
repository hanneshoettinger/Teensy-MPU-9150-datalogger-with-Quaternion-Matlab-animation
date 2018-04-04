function image = getBinaryImageWithLine(height, width, startPoint, endPoint)
%GETBINARYIMAGEWITHLINE Create binary image with a line.
%   IMAGE = GETBINARYIMAGEWITHLINE(HEIGHT, WIDTH, STARTPOINT, ENDPOINT)
%   creates a binary image of given dimensions on which appears a line
%   specified by its start and end points.

%   Author: Damien Teney

image = zeros(height, width);

% Obtain points along the line
maxLineSize = 2 * max(width, height);
pointsYCoordinates = round(linspace(startPoint(1), endPoint(1), maxLineSize));
pointsXCoordinates = round(linspace(startPoint(2), endPoint(2), maxLineSize));

for i = 1:size(pointsYCoordinates, 2)
  if pointsYCoordinates(i) <= 0 || ...
     pointsXCoordinates(i) <= 0 || ...
     pointsYCoordinates(i) > height || ...
     pointsXCoordinates(i) > width
    continue;
  end
  image(pointsYCoordinates(i), pointsXCoordinates(i)) = 1;
end
