function v = v3_getUnit(v)
%V3_GETUNIT Normalize 3-vector.
%   V = V3_GETUNIT(v) divides a 3-vector V by its own length and returns
%   it.

%   Author: Damien Teney

v = v ./ norm(v);
