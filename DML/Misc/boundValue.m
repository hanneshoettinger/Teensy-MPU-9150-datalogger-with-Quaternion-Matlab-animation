function b = boundValue(a, minValue, maxValue)
%BOUNDVALUE Enforce bounds on a number given min and max limits.
%   B = BOUNDVALUE(A, MINVALUE, MAXVALUE) returns the input value A as-is,
%   except if it's outside the range [MINVALUE,MAXVALUE], in which case the
%   closest bound is returned. Also works on vectors of values.

%   Author: Damien Teney

assert(minValue < maxValue);

b = max(a, minValue);
b = min(b, maxValue);
