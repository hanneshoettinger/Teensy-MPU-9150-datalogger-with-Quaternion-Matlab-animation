function v = v3_getRandom()
%V3_GETRANDOM Random unit 3-vectors, uniformly distributed on the 2-sphere.
%   V = V3_GETRANDOM() returns a random unit 3-vector (1x3), uniformely
%   distributed on the 2-sphere.

%   Author: Damien Teney

% Reference: see (6), (7), (8) in
% http://mathworld.wolfram.com/SpherePointPicking.html.

theta = 2 * pi * rand(); % v ~ U[0,2*pi]
u = 2 * rand() - 1; % u ~ U[-1,1]

v = zeros(1, 3);
tmp = sqrt(1 - u*u);
v(1) = tmp * cos(theta);
v(2) = tmp * sin(theta);
v(3) = u;
