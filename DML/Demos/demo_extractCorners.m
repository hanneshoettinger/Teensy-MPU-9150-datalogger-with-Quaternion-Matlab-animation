function demo_extractCorners
%DEMO_EXTRACTCORNERS Demo of a corner detector.

image = imread('demo_extractCorners.bmp');
corners = extractCorners(image)

% Display the result
global CAMERA_CALIBRATION;
CAMERA_CALIBRATION{1}.IMAGE_WIDTH = 1024;
CAMERA_CALIBRATION{1}.IMAGE_HEIGHT = 768;
displayEmpty2DFigure();
for i = 1:size(corners)
  plot(corners(i, 1), corners(i, 2), '.');
end
