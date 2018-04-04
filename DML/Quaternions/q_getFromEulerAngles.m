function q = q_getFromEulerAngles(x, y, z, order)
%Q_GETFROMEULERANGLES Quaternion from Euler angles.
%   Q = Q_GETFROMEULERANGLES(A, B, C, ORDER) returns the quaternion
%   equivalent to rotations around the axes X/Y/Z (angles given in
%   radians), applied in the given order.
%
%   ORDER can be, e.g. [1 2 3] for XYZ, or [3 2 1] for ZYX.

%   Author: Damien Teney

% Check input argument 'order'
if nargin < 4
  order = [1 2 3]; % Default value
end
assert(numel(order) == 3);
assert(numel(unique(order)) == 3);

q = [1 0 0 0];
for i = 1:3
  switch order(i)
    case 1
      newQ = [cos(x / 2) sin(x / 2)          0          0]; % Around X axis
    case 2
      newQ = [cos(y / 2)          0 sin(y / 2)          0]; % Around Y axis
    case 3
      newQ = [cos(z / 2)          0          0 sin(z / 2)]; % Around Z axis
    otherwise
      error('Invalid value in ORDER.')
  end
  q = q_mult(newQ, q);
end
