function [phi psi] = v3_getEulerAngles(v)
%V3_GETANGLES Euler angle of an orientation on the 2-sphere.
%   V = V3_GETANGLES(PHI, PSI) returns the two euler angles describing an
%   orientation on the 2-sphere, defined by the given 3-vector.
%
%   The angles are given in radians.

%   Author: Damien Teney

% Get phi from v(3)
phi = acos(v(3));
if v(2) < 0
  phi = -phi;
end

x = v(1) / sin(phi);
y = v(2) / -sin(phi);
% Now we have:
% norm([x y]) = 1
% x = cos(psi)
% y = sin(psi)
psi = acos(x);
if y < 0
  psi = -psi;
end
