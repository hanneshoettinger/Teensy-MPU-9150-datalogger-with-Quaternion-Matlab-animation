function result = getAngleDifference_half(angle1, angle2, unsigned)
%GETANGLEDIFFERENCE_HALF Difference between two angles in [0, pi[.
%   A = GETANGLEDIFFERENCE_HALF(ANGLE1, ANGLE2, UNSIGNED) computes the
%   shortest (signed by default) difference from ANGLE1 to ANGLE2. Both
%   angles must be in [0, pi[, and we assume that ANGLE and (ANGLE + PI)
%   represent the same thing.
%
%   The returned difference is in [-pi/2, pi/2[ (signed) or [0, pi/2[
%   (unsigned).
%
%   Also works with vectors of angles (of the same size).

%   Author: Damien Teney

% Make sure the input angles are in the correct range
assert(all(angle1 >= 0 & angle1 < pi));
assert(all(angle2 >= 0 & angle2 < pi));

if nargin > 2 && unsigned
  % Unsigned difference
  tmp = abs(angle2 - angle1);
  result = min(tmp, pi - tmp);
else % Default case
  % Signed difference
  tmp = angle2 - angle1;
  valuesToCompare = [(tmp) (tmp + pi) (tmp - pi)];
  [minValue minValueIndex] = min(abs(valuesToCompare));
  result = valuesToCompare(minValueIndex);
end
