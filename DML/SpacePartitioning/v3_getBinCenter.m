function binCenter = v3_getBinCenter(binIndex, resolution)
%V3_GETBINCENTER Bin center from its index.
%   BINCENTER = V3_GETBINCENTER(BININDEX, RESOLUTION) returns the center of
%   a bin identified by its index.
%
%   RESOLUTION must be >= 0
%
%   This uses the concept of the hierarchical triangle mesh on the 2-shere.
%   See:
%   http://www.skyserver.org/htm

%   Author: Damien Teney

% Get the limits/corners of the bin
[corner0 corner1 corner2] = v3_getBinLimits(binIndex, resolution);

% Get the center of the bin

% Option 1: centroid
%binCenter = (corner0 + corner1 + corner2) / 3; %

% Option 2: center of the inscribed circle
% See: http://en.wikipedia.org/wiki/Incenter
%%{
length0 = norm(corner2 - corner1);
length1 = norm(corner2 - corner0);
length2 = norm(corner1 - corner0);
lengthSum = length0 + length1 + length2;
binCenter = (length0 * corner0 + length1 * corner1 + length2 * corner2) / lengthSum;
%}

% Make sure the point is on the sphere
binCenter = binCenter ./ norm(binCenter);
