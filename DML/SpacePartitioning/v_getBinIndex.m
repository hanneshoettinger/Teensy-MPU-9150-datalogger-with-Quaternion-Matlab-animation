function binIndex = v_getBinIndex(v, minValues, maxValues, nBins)
%V_GETBININDEX Bin index from a vector.
%   BININDEX = V_GETBININDEX(V, MINVALUES, MAXVALUES, NBINS) performs
%   basically the same operation as GETBININDEX, but on several dimensions.

%   Author: Damien Teney

nDimensions = numel(v);

  % Check that all arguments have the same dimensions
assert(nDimensions == numel(v));
assert(nDimensions == numel(minValues));
assert(nDimensions == numel(maxValues));
assert(nDimensions == numel(nBins));

% Get indices in each dimension
binIndexPerDimension = zeros(1, nDimensions);
for d = 1:nDimensions % For each dimension
  binIndexPerDimension(d) = getBinIndex(v(d), minValues(d), maxValues(d), nBins(d));
end

% Get the multipliers for the indices
% See: http://en.wikipedia.org/wiki/Row-major_order
multipliers = zeros(1, nDimensions);
multipliers(1) = 1;
for d = 2:nDimensions % For each dimension
  % The dimensions are (chosen to be) more and more significant as d increases
  multipliers(d) = multipliers(d - 1) * nBins(d - 1);
end

% Get a linear index
binIndex = 0;
for d = 1:nDimensions % For each dimension
  binIndex = binIndex + binIndexPerDimension(d) * multipliers(d);
end
