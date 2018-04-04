function [corner0 corner1 corner2] = v3_getBinLimits(binIndex, resolution)
%V3_GETBINLIMITS Bin limits from its index.
%   [CORNER0 CORNER1 CORNER2] = V3_GETBINLIMITS(BININDEX, RESOLUTION)
%   returns the 3 corners that define the (triangular) bin identified by
%   the given index.
%
%   RESOLUTION must be >= 0
%
%   This uses the concept of the hierarchical triangle mesh on the 2-shere.
%   See:
%   http://www.skyserver.org/htm

%   Author: Damien Teney

binIndex = uint32(binIndex); % Make sure we have an unsigned integer

% Get the uppermost triangle
k = 0;
currentLevelIndex = bitshift(binIndex, -2 * (resolution - k));
[corner0 corner1 corner2] = getInitialHtmTriangle(currentLevelIndex);

for k = 1:resolution % For each character of the name
  midPoint2 = getMiddlePoint(corner0, corner1);
  midPoint0 = getMiddlePoint(corner1, corner2);
  midPoint1 = getMiddlePoint(corner2, corner0);

  currentLevelIndex = bitshift(binIndex, -2 * (resolution - k));
  currentLevelIndex = bitand(currentLevelIndex, bin2dec('11'));

  % Subdivide the triangle
  switch currentLevelIndex
    case 0
      corner1 = midPoint2;
      corner2 = midPoint1;
    case 1
      corner0 = corner1;
      corner1 = midPoint0;
      corner2 = midPoint2;
    case 2
      corner0 = corner2;
      corner1 = midPoint1;
      corner2 = midPoint0;
    case 3
      corner0 = midPoint0;
      corner1 = midPoint1;
      corner2 = midPoint2;
    otherwise
      error('Error !');
  end
end

corner0 = v3_getUnit(corner0);
corner1 = v3_getUnit(corner1);
corner2 = v3_getUnit(corner2);
