function [v2 v3] = v3_getOrthogonalOnes(v1)
%V3_GETORTHOGONALONES Two orthogonal 3-vectors to a given one.
%   [V2 V3] = V3_GETORTHOGONALONES(V1) takes a given 3-vector V1, and
%   returns two other vectors so that V1, V2, V3 form a basis of R3.

%   Author: Damien Teney

v2(1) = v1(2); % Arbitrary choice
v2(2) = v1(1); % Ditto
v2(3) = (-2 * v1(1) * v1(2)) / v1(3);
v2 = v3_getUnit(v2);

v3 = cross(v1, v2);

% Debug check
%dot(v1, v2), dot(v2, v3), dot(v1, v3) % Should all be 0
%norm(v1), norm(v2), norm(v3)
