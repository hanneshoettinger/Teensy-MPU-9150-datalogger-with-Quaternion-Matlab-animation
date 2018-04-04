function demo_rotate2DPoint
%DEMO_ROTATE2DPOINT Demo of rotation of a 2D point.

displayEmpty2DFigure();

% Point
point = [50 100];
plot(point(1), point(2), 'b.');

% Rotation center
center = [150 150];
plot(center(1), center(2), '+r');

% Rotated point
for angle = 0:deg2rad(5):deg2rad(90)
  rotatedPoint = rotate2DPoint(point, center, angle);
  plot(rotatedPoint(1), rotatedPoint(2), 'b.');
end
