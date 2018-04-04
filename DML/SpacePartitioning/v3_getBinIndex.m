function binIndex = v3_getBinIndex(v, resolution)
%V3_GETBININDEX Bin index from (unit length) 3-vector.
%   BININDEX = V3_GETBININDEX(V, RESOLUTION) divides the 2-sphere into bins
%   of similar shape and area, and determines in which the given vector V
%   falls.
%
%   BININDEX is in [0,V3_GETBINCOUNT(RESOLUTION)[
%   RESOLUTION must be >= 0
%
%   This uses the concept of the hierarchical triangle mesh on the 2-shere.
%   See:
%   http://www.skyserver.org/htm

%   Author: excerpt from the HTM (http://www.skyserver.org/htm), modified
%   by Damien Teney

assert(isAlmostEqual(norm(v), 1));

%------------------------------------------------------------------------
% Get the ID at the top
%------------------------------------------------------------------------
x = v(1); y = v(2); z = v(3); % Rename for clearer code

% Define constants
S0 = 0; S1 = 1; S2 = 2; S3 = 3;
N0 = 4; N1 = 5; N2 = 6; N3 = 7;

if (x > 0) && (y >= 0)
  if z >= 0
    binIndex = N3;
  else
    binIndex = S0;
  end
elseif (x <= 0) && (y > 0)
  if z >= 0
    binIndex = N2;
  else
    binIndex = S1;
  end
elseif (x < 0) && (y <= 0)
  if z >= 0
    binIndex = N1;
  else
    binIndex = S2;
  end
elseif (x >= 0) && (y < 0)
  if z >= 0
    binIndex = N0;
  else
    binIndex = S3;
  end
else
  if z >= 0
    binIndex = N3;
  else
    binIndex = S0;
  end
end
binIndex = uint32(binIndex); % Make sure we still have an unsigned integer

% Get the initial triangle corners
[corner0 corner1 corner2] = getInitialHtmTriangle(binIndex);

%binIndex = binIndex + 8; % Append a '1' bit first, as in the original implementation of the HTM

%------------------------------------------------------------------------
% Searching for the children
%------------------------------------------------------------------------
for k = (resolution - 1):-1:0 % For each level, down to the requested resolution
  %binIndex <<= 2; % Bit shift
  binIndex = bitshift(binIndex, 2);

  midPoint2 = getMiddlePoint(corner0, corner1);
  midPoint0 = getMiddlePoint(corner1, corner2);
  midPoint1 = getMiddlePoint(corner2, corner0);

  if isPointInsideHtmTriangle(v, corner0, midPoint2, midPoint1)
    % binIndex = bitor(binIndex, 0);

    corner1 = midPoint2;
    corner2 = midPoint1;
  elseif isPointInsideHtmTriangle(v, corner1, midPoint0, midPoint2)
    binIndex = bitor(binIndex, 1);

    corner0 = corner1;
    corner1 = midPoint0;
    corner2 = midPoint2;
  elseif isPointInsideHtmTriangle(v, corner2, midPoint1, midPoint0)
    binIndex = bitor(binIndex, 2);

    corner0 = corner2;
    corner1 = midPoint1;
    corner2 = midPoint0;
  elseif isPointInsideHtmTriangle(v, midPoint0, midPoint1, midPoint2)
    binIndex = bitor(binIndex, 3);

    corner0 = midPoint0;
    corner1 = midPoint1;
    corner2 = midPoint2;
  else
    error('Error !'); % Should never happen
  end
end

binIndex = double(binIndex); % Convert to a double since it's more common in Matlab
