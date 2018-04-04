function M = getHysteresisThresholdedMap(M, lowThreshold, highThreshold)
%GETHYSTERESISTHRESHOLDEDMAP Hysteresis thresholding.
%   M = GETHYSTERESISTHRESHOLDEDMAP(M, LOWTHRESHOLD, HIGHTHRESHOLD) applies
%   hysteresis thresholding to the given map M (MxN matrix). The result is
%   map of binary values

%   Author: Damien Teney

assert(lowThreshold < highThreshold);

[coordinatesI coordinatesJ] = find(M > highThreshold); % Coordinates of points above the high threshold
M = bwselect(M > lowThreshold, coordinatesJ, coordinatesI, 8);
