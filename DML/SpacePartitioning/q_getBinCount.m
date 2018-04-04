function binCount = q_getBinCount(resolution)
%Q_GETBINCOUNT Number of bins at a given resolution.
%   BINCOUNT = Q_GETBINCOUNT(RESOLUTION) returns the number of bins used
%   to divide the 3-sphere.
%
%   RESOLUTION must be >= 0

%   Author: Damien Teney


binCount1 = v3_getBinCount(resolution);
binCount2 = q_getBinCountAngle(binCount1);

binCount = binCount1 * binCount2;
