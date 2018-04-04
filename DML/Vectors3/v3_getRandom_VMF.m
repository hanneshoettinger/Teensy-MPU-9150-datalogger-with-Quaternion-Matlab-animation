function v = v3_getRandom_VMF(mu, kappa, n)
%V3_GETRANDOM_VMF Random unit 3-vector from von Mises-Fisher distribution.
%   V = V3_GETRANDOM_VMF(MU, KAPPA, N) returns a unit 3-vector distributed on
%   the 2-sphere according to a von Mises-Fisher distribution of parameters
%   MU (1x3) and KAPPA (>= 0).
%
%   Can generate several (N) samples at a time; V is then Nx3.

%   Author: Sungkyu Jung, modified by Damien Teney
%   See: http://www.unc.edu/~sungkyu/manifolds/randvonMisesFisher3.m

if nargin < 3
  n = 1; % Default value
end

% Special case
if kappa == +inf
  v = repmat(mu, n, 1);
  return;
end

% Get a random sample of mean orientation [1 0 0]
c = 2 / kappa * (sinh(kappa)); % Normalization constant
y = rand(n, 1);
w = 1/kappa * log(exp(-kappa) + kappa * c * y);

angle = 2 * pi * rand(n, 1);
tmp = [cos(angle) sin(angle)];

v = [w repmat(sqrt(1 - w.^2), 1, 2) .* tmp];

% Set in the right direction
rotationQuaternion = q_getRotationBetweenVectors([1 0 0], mu);
for i = 1:n
  v(i, 1:3) = q_rotatePoint(v(i, 1:3), rotationQuaternion);
end
