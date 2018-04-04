function demo_linesClosestPoints()
%DEMO_LINESCLOSESTPOINTS Demo of the closests points of 2 3D lines.

displayEmpty3DFigure();
axis square;
grid on;

% Define the lines and display them
line1Point1 = [-7 -12 -18];
line1Point2 = [10 15 2];
plot3([line1Point1(1) line1Point2(1)], ...
      [line1Point1(2) line1Point2(2)], ...
      [line1Point1(3) line1Point2(3)], 'b-.');
line2Point1 = [7 -12 4];
line2Point2 = [-12 3 -14];
plot3([line2Point1(1) line2Point2(1)], ...
      [line2Point1(2) line2Point2(2)], ...
      [line2Point1(3) line2Point2(3)], 'r-.');

% Get the closest points on both lines
[point1 point2] = getLinesClosestPoints(line1Point1, line1Point2, line2Point1, line2Point2);

% Display them
plot3(point1(1), point1(2), point1(3), 'b.');
plot3(point2(1), point2(2), point2(3), 'r.');

% Middle of them
midPoint = point1 + (point2 - point1) / 2;
plot3([point1(1) point2(1)], [point1(2) point2(2)], [point1(3) point2(3)], 'k-');
plot3(midPoint(1), midPoint(2), midPoint(3), 'k+');
