function [corner00 corner01 corner02 corner10 corner11 corner12] = q_getBinLimits(binIndex, resolution)
%Q_GETBINLIMITS Bin limits from its index.
%   [CORNER00 CORNER01 CORNER02 CORNER10 CORNER11 CORNER12] =
%   Q_GETBINLIMITS(BININDEX, RESOLUTION) returns the corners that delimit
%   the bin identified by the given index.
%
%   RESOLUTION must be >= 0

%   Author: Damien Teney

% Get the two sperate binIndex* back
binCount1 = v3_getBinCount(resolution);
binCount2 = q_getBinCountAngle(binCount1);

binIndex1 = floor(binIndex / binCount2);
binIndex2 = binIndex - (binIndex1 * binCount2);

if binIndex1 < 0 || binIndex1 > binCount1 ...
|| binIndex2 < 0 || binIndex2 > binCount2
  error('Invalid bin index !');
end

%--------------------------------------------------------------------------
% First part (on S2)
%--------------------------------------------------------------------------
[axis0 axis1 axis2] = v3_getBinLimits(binIndex1, resolution);

%--------------------------------------------------------------------------
% Second part (on S1)
%--------------------------------------------------------------------------
% Get the angles
angle0 = ((binIndex2    ) / binCount2) * 2 * pi; % Lower bound of the bin
angle1 = ((binIndex2 + 1) / binCount2) * 2 * pi; % Upper bound of the bin

%--------------------------------------------------------------------------
% Put both parts together
%--------------------------------------------------------------------------
corner00 = q_getFromHopfAxisAngle(axis0, angle0);
corner01 = q_getFromHopfAxisAngle(axis1, angle0);
corner02 = q_getFromHopfAxisAngle(axis2, angle0);
corner10 = q_getFromHopfAxisAngle(axis0, angle1);
corner11 = q_getFromHopfAxisAngle(axis1, angle1);
corner12 = q_getFromHopfAxisAngle(axis2, angle1);
