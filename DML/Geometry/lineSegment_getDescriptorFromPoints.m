function descriptor = lineSegment_getDescriptorFromPoints(pt1, pt2)
%LINESEGMENT_GETDESCRIPTORFROMPOINTS Descriptor of 2D line segment (center/orientation/length) from its ending points.
%   DESCRIPTOR = LINESEGMENT_GETDESCRIPTORFROMPOINTS(PT1, PT2) returns a
%   1x4 vector description of a line segment (center point/orientation/
%   length), given its start/end points (1x2 vectors).
%
%   The orientation is given as an angle, in radians, in [o, pi[.

%   Author: Damien Teney

descriptor = zeros(1, 4);

descriptor(1:2) = pt1 + 0.5 * (pt2 - pt1); % Center
descriptor(3)   = mod(getOrientationFrom2DPoints(pt1, pt2), pi); % Orientation in [0, pi[
descriptor(4)   = norm(pt2 - pt1); % Length
