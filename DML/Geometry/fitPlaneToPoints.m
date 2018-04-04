function planeOrthogonalVector = fitPlaneToPoints(points, displayFlag)
%FITPLANETOPOINTS Plane fit to 3D points.
%   PLANEORTHOGONALVECTOR = FITPLANETOPOINTS(POINTS, DISPLAYFLAG) finds a
%   plane that fits best the given 3D points (Nx3). Returns a vector (1x3)
%   orthogonal to this plane.

%   Author: Damien Teney

x = points(:, 1);
y = points(:, 2);
z = points(:, 3);

% Least squares fit, such as: z = c(1)*x + c(2)*y + c(3)
A = [x y ones(size(x))]; % Matrix of overdetermined system
c = A \ z; % Least squares solution

% Get a vector orthogonal to the plane
planeOrthogonalVector = zeros(1, 3);
planeOrthogonalVector(1) = c(1);
planeOrthogonalVector(2) = c(2);
planeOrthogonalVector(3) = -1;
planeOrthogonalVector = v3_getUnit(planeOrthogonalVector); % Normalize

if nargin > 1 && displayFlag
  displayEmpty3DFigure('Plane fitting')

  % Display the points
  plot3(x, y, z, '.');
  plot3([0 50 * planeOrthogonalVector(1)], ...
        [0 50 * planeOrthogonalVector(2)], ...
        [0 50 * planeOrthogonalVector(3)], 'r.-');

  % Display the plane
  xb = [min(x); min(x); max(x); max(x)];
  yb = [min(y); max(y); max(y); min(y)];
  zb = c(1) * xb + c(2) * yb + c(3);
  fill3(xb, yb, zb, [0.75 0.75 0.75]);
end
