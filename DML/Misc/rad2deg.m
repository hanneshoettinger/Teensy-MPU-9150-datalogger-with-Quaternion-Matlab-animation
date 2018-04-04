function angleInDegrees = rad2deg(angleInRadians)
%RADTODEG Convert angles from radians to degrees.
%   ANGLEINRADIANS = DEG2RAD(ANGLEINDEGREES) converts angle units from
%   degrees to radians.

%   Author: Damien Teney

angleInDegrees = 180 .* (angleInRadians ./ pi);
