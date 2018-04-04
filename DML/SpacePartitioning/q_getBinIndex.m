function binIndex = q_getBinIndex(q, resolution)
%Q_GETBININDEX Bin index from unit quaternion.
%   BININDEX = Q_GETBININDEX(Q, RESOLUTION) divides the 3-sphere into bins
%   of similar shape and area, and determines in which the given quaternion
%   Q falls.
%
%   BININDEX is in [0,Q_GETBINCOUNT(RESOLUTION)[
%   RESOLUTION must be >= 0

%   Author: Damien Teney

assert(isAlmostEqual(norm(q), 1));

% Separate the quaterion into 2 elements
[axis angle] = q_getHopfAxisAngle(q);

% Get the number of bins
binCount1 = v3_getBinCount(resolution);
binCount2 = q_getBinCountAngle(binCount1);

binIndex = v_getBinIndex([angle     v3_getBinIndex(axis, resolution)], ...
                         [0         0                               ], ...
                         [(2 * pi)  binCount1                       ], ...
                         [binCount2 binCount1                       ]);
