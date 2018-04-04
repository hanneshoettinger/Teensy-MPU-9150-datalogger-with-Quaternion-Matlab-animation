function points = q_getUniformGrid(resolution)
%Q_GETUNIFORMGRID Uniformely distributed grid of points on the 3-sphere.
%   POINTS = Q_GETUNIFORMGRID(RESOLUTION) returns a list of points (unit
%   quaternions, Nx4 matrix) that form a uniformely distributed grid on the
%   3-sphere.
%
%   RESOLUTION must be >= 0

%   Author: Damien Teney

binCount1 = v3_getBinCount(resolution);
binCount2 = q_getBinCountAngle(binCount1);

nPoints = binCount1 * binCount2;
%points = zeros(nPoints, 4);
points = zeros(0, 4);

angle = 0;
for i = 1:binCount2 % For each point to get
  v3Grid = v3_getUniformGrid(resolution);
  for j = 1:binCount1
    v = v3Grid(j, 1:3);
    q = q_getFromHopfAxisAngle(v, angle);

    points = [points ; q]; % Append the new quaternion
  end

  angle = angle + (2 * pi) / binCount2;
end

assert(size(points, 1) == nPoints);
