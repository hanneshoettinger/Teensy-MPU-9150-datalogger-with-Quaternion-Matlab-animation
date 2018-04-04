function binCenter = q_getBinCenter(binIndex, resolution)
%Q_GETBINCENTER Bin center from its index.
%   BINCENTER = Q_GETBINCENTER(BININDEX, RESOLUTION) returns the center of
%   a bin identified by its index.
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
axis = v3_getBinCenter(binIndex1, resolution);

%--------------------------------------------------------------------------
% Second part (on S1)
%--------------------------------------------------------------------------
% Get the angle
angle = ((binIndex2 + 0.5) / binCount2) * 2 * pi; % Middle of the bin

%--------------------------------------------------------------------------
% Put both parts together
%--------------------------------------------------------------------------
binCenter = q_getFromHopfAxisAngle(axis, angle);
