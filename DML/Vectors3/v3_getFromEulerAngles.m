function v = v3_getFromEulerAngles(phi, psi)
% V3_GETFROMEULERANGLES  Orientation on the 2-sphere from its Euler angles.
%   V = V3_GETFROMEULERANGLES(phi, psi) returns the 3-vector, describing an
%   orientation on the 2-sphere, defined by two euler angles phi and psi.
%
%   The angles are given in radians.

%   Author: Damien Teney

v = zeros(1, 3);

v(1) = sin(phi) * cos(psi);
v(2) = -sin(phi) * sin(psi);
v(3) = cos(phi);
