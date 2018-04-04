function demo_extractEdgePoints
%DEMO_EXTRACTEDGEPOINTS Demo of extraction of points along edges.

inputFileName = selectFileToOpen('Select image file', 'png', '');
image = imread(inputFileName);

%edgeMap = edge(rgb2gray(image), 'canny', .15, 3);
%edgeMap = getEdgeMap(image, 0.15, 4);
%edgeMap = edge(rgb2gray(image), 'canny', .15, 4);
%edgeMap = edge(rgb2gray(image), 'canny', .28, 3);
edgeMap = edge(rgb2gray(image), 'canny', .2, 0.8);

figure(); imshow(image); % Display the input image
figure(); imshow(~edgeMap); % Display the edge map
drawnow();

printf('Min distance between points: %2d     Number of points: %4d\n', 0, numel(find(edgeMap)));

minDistance = 3;

edgePoints = extractEdgePoints(edgeMap, minDistance);

% Display the result
global CAMERA_CALIBRATION;
CAMERA_CALIBRATION{1}.IMAGE_WIDTH = size(image, 2);
CAMERA_CALIBRATION{1}.IMAGE_HEIGHT = size(image, 1);

displayEmpty2DFigure();
displayOrientedPoints2D(edgePoints, 'bars', 5);
figure(); imshow(~edgeMap); hold on;
for i = 1:size(edgePoints)
  plot(edgePoints(i, 1), edgePoints(i, 2), 'b.');
end
