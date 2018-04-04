function points = v3_getUniformGrid(resolution)
%V3_GETUNIFORMGRID Uniformely distributed grid of points on the 2-sphere.
%   POINTS = V3_GETUNIFORMGRID(RESOLUTION) returns a list of points (unit
%   3-vectors, Nx3 matrix) that form a uniformely distributed grid on the
%   2-sphere.
%
%   RESOLUTION must be >= 0
%
%   This uses the concept of the hierarchical triangle mesh on the 2-shere.
%   See:
%   http://www.skyserver.org/htm

%   Author: Damien Teney

binCount = v3_getBinCount(resolution);
points = zeros(binCount, 3);

for index = 0:(binCount - 1) % For every possible index
  points(index + 1, 1:3) = v3_getBinCenter(index, resolution); % Get the center of the bin of the current index
end
