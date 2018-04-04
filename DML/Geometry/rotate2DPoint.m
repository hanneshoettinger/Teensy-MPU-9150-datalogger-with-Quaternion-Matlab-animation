function rotatedPoint = rotate2DPoint(point, center, angle)
%ROTATE2DPOINT Rotate 2D point.
%   ROTATEDPOINT = ROTATE2DPOINT(POINT, CENTER, ANGLE) rotates a given 2D
%   point around a given center with a given angle (in radians).

%   Author: Damien Teney

point(1:2) = point(1:2) - center(1:2);

% Get polar coordinates
%[th r] = cart2pol(point(1), point(2)); % Equivalent to the formulae below
x = point(1); y = point(2);
r = sqrt(x * x + y * y);
th = atan2(y, x);

% Rotate the point
th = th + angle;

% Get back cartesian coordinates
%[x y] = pol2cart(th, r); % Equivalent to the formulae below
x = r * cos(th);
y = r * sin(th);
rotatedPoint(1:2) = [x y];

rotatedPoint(1:2) = rotatedPoint(1:2) + center(1:2);
