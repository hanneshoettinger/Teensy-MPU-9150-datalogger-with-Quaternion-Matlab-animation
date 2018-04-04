function angle = getAngleFromSinCos(estimatedSine, estimatedCosine)
%GETANGLEFROMSINCOS Angle from sine and cosine.
%   ANGLE = GETANGLEFROMSINCOS(ESTIMATEDSINE, ESTIMATEDCOSINE) finds the
%   angle (in radians) matching its estimated sine and cosine.

%   Author: Damien Teney

% Normalize such that (sin^2 + cos^2) = 1
norm = sqrt(estimatedSine^2 + estimatedCosine^2);
estimatedSine = estimatedSine / norm;
estimatedCosine = estimatedCosine / norm;

% Estimation 1: with the sine
angle1 = asin(estimatedSine);
if estimatedCosine < 0
  angle1 = (pi / 2) - angle1;
end

% Estimation 2: with the cosine
% Note that the result will be the same since we normalized (sin,cos)
angle2 = acos(estimatedCosine);
if estimatedSine < 0
  angle2 = (2 * pi) - angle2;
end

% Force angles in (mod360) space
angle1 = mod(angle1, 2 * pi);
angle2 = mod(angle2, 2 * pi);

angle = angle1;
