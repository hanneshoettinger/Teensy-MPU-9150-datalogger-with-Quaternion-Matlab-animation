function q = q_getRotationBetweenVectors(v1, v2)
% Q_GETROTATIONBETWEENVECTORS  Shortest rotation from one vector onto another.
%   Q = Q_GETROTATIONBETWEENVECTORS(V1, V2) returns the quaternion Q such
%   that V2 = Q_ROTATEPOINT(V1, Q).

%   Author: Damien Teney

if dot(v1, v2) == 1 % Equivalent to isequal(v1, v2) but numerically more stable
  % Special case: null rotation
  q = [1 0 0 0];
elseif dot(v1, v2) == -1 % Equivalent to isequal(v1, -v2) but numerically more stable
  % Special case: 180deg rotation
  % Find any orthogonal vector to v1
  % Different cases for better numerical stability (and avoid divisions by 0)

  if v1(1) == 0 % Very special case
    axis(1) = v1(2);
    axis(2) = v1(3);
    axis(3) = 0;
  elseif v1(2) == 0 % Very special case
    axis(1) = v1(3);
    axis(2) = 0;
    axis(3) = v1(1);
  elseif v1(3) == 0 % Very special case
    axis(1) = 0;
    axis(2) = v1(3);
    axis(3) = v1(2);
  elseif max(v1) == v1(3)
    axis(1) = v1(3);
    axis(2) = v1(2);
    axis(3) = -(v1(1) * axis(1) + v1(2) * axis(2)) / v1(3);
  elseif max(v1) == v1(2)
    axis(1) = v1(3);
    axis(3) = v1(1);
    axis(2) = -(v1(1) * axis(1) + v1(3) * axis(3)) / v1(2);
  else % max(v1) == v1(1)
    axis(3) = v1(2);
    axis(2) = v1(3);
    axis(1) = -(v1(3) * axis(3) + v1(2) * axis(2)) / v1(1);
  end
  assert(dot(v1, axis) == 0);
  q = q_getFromEulerAxisAngle(axis, pi);
else
  % See:
  % http://www.euclideanspace.com/maths/algebra/vectors/angleBetween/index.htm
  q(1) = norm(v1) * norm(v2) + dot(v1, v2);
  %q(1) = sqrt(norm(v1)^2 * norm(v2)^2) + dot(v1, v2); % Same
  q(2:4) = cross(v1, v2);

  q = q ./ norm(q);
end
