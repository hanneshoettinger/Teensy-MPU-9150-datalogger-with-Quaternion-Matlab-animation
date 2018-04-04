function result = getAngleDifference(angle1, angle2, unsigned)
%GETANGLEDIFFERENCE Difference between two angles.
%   A = GETANGLEDIFFERENCE(ANGLE1, ANGLE2, UNSIGNED) computes the shortest
%   (signed by default) difference from ANGLE1 to ANGLE2.
%
%   Also works with vectors of angles (of the same size).

%   Author: Damien Teney

% Check parameters in case they are vectors
angle1 = angle1(:)';
angle2 = angle2(:)';
assert(length(angle1) == length(angle2));
nAngles = length(angle1);

if nargin > 2 && unsigned
  % Unsigned difference
  tmp = abs(angle2 - angle1);
  result = min(tmp, 2 * pi - tmp);
else % Default case
  % Signed difference
  tmp = angle2 - angle1;
  valuesToCompare = [(tmp) (tmp + 2*pi) (tmp - 2*pi)];
  [minValue minValueIndex] = min(abs(valuesToCompare'));
  result = valuesToCompare(sub2ind(size(valuesToCompare), 1:nAngles, minValueIndex));
  result = mod(result, 2 * pi);
end
