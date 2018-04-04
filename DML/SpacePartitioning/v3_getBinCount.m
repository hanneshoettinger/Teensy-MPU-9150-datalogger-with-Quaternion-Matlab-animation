function binCount = v3_getBinCount(resolution)
%V3_GETBINCOUNT Number of bins at a given resolution.
%   BINCOUNT = V3_GETBINCOUNT(RESOLUTION) returns the number of bins used
%   to divide the 2-sphere.
%
%   RESOLUTION must be >= 0
%
%   This uses the concept of the hierarchical triangle mesh on the 2-shere.
%   See:
%   http://www.skyserver.org/htm

%   Author: Damien Teney

binCount = 8 * 4 ^ resolution;
