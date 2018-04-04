function binIndex = getBinIndex(x, minValue, maxValue, nBins)
%GETBININDEX Bin index from a scalar.
%   BININDEX = GETBININDEX(X, MINVALUE, MAXVALUE, NBINS) divides the range
%   between MINVALUE and MAXVALUE into NBINS bins of equal size, and then
%   determines in which bin the given value X falls.

%   Author: Damien Teney

assert(numel(x) == 1);

if x >= maxValue
  %warning('Value too large !');
  binIndex = nBins - 1;
elseif x <= minValue
  %warning('Value too small !');
  binIndex = 0;
else
  binIndex = floor((x - minValue) * nBins / (maxValue - minValue));
end

assert(binIndex >= 0 && binIndex < nBins);
