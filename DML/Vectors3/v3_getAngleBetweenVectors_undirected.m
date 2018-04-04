function angles = v3_getAngleBetweenVectors_undirected(v1, v2s)
%V3_GETANGLEBETWEENVECTORS_UNDIRECTED Angle between undirected 3-vectors.
%   ANGLES = V3_GETANGLEBETWEENVECTORS_UNDIRECTED(V1, V2S) returns the list
%   of the angles (1xN) between V1 (1x3) and each row of V2S (Nx3).
%
%   The vectors are considered without direction, ie v = -v.
%
%   Warning: the vectors must be normalized beforehand.
%
%   The angles are in radians and comprised in [0, pi / 2].

%   Author: Damien Teney

% Normalize the vectors
%{
v1 = v1 ./ norm(v1);
v2s = sqrt(sum(v2s.^2, 2));
%}

v1s = v1(ones(1, size(v2s, 1)), :); % Replicate v1 (get as many rows as v2s)
tmp = dot(v1s, v2s, 2); % Dot product, row by row
tmp = abs(tmp); % Take the absolute value to ensure we keep the shortest arc, not taking into account the direction
angles = acos(tmp)';
