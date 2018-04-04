function [x y z] = q_getEulerAngles(q, order)
%Q_GETEULERANGLES Euler angles from quaternion.
%   [X Y Z] = Q_GETEULERANGLES(Q, ORDER) returns the angles (in radians) of
%   rotations around the axes X/Y/Z which, applied the given order, are
%   equivalent to the given quaternion Q.
%
%   ORDER can be, e.g. [1 2 3] for XYZ, or [3 2 1] for ZYX.

%   Author:
%   http://sneg.co.uk/content/euler-angles-quaternion-transformation-and-back-independent-rotation-order
%   modified by Damien Teney

 % Check input argument 'order'
if nargin < 2
  order = [1 2 3]; % Default value
end
assert(numel(order) == 3);
assert(numel(unique(order)) == 3);

result = zeros(1, 3);

% Rearrange quaternion coefficients according to ORDER
% If the order is ZYX, then the coefficients will be [qw, qz, qy, qx]
% The last item is e, which is the coefficient used in the transformation:
% e = dot(cross(e3, e2), e1) where e1,e2,e3 are axis of rotation
p = zeros(1,4);
p(1) = q(1);
p(order(1) + 1) = q(2);
p(order(2) + 1) = q(3);
p(order(3) + 1) = q(4);
axis = cell(1,3);
axis{order(1)} = [1,0,0];
axis{order(2)} = [0,1,0];
axis{order(3)} = [0,0,1];
interim = cross(axis{3}, axis{2});
f = dot(interim, axis{1});
p(5) = f ;

result(2) = asin(2 * p(1) * p(3) + 2 * p(5) * p(2) * p(4));

if result(2) == pi/2 || result(2) == -pi/2
  result(1) = atan2( p(2), p(1) );
  result(3) = 0;
else
  result(1) = atan2( 2 * ( p(1) * p(2) - p(5) * p(3) * p(4) ), 1 - 2 * ( p(2) * p(2) + p(3) * p(3) ) );
  result(3) = atan2( 2 * ( p(1) * p(4) - p(5) * p(2) * p(3) ), 1 - 2 * ( p(3) * p(3) + p(4) * p(4) ) );
end

x = result(order(1));
y = result(order(2));
z = result(order(3));
