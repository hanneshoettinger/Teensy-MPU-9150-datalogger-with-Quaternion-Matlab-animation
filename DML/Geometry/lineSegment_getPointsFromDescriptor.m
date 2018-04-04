function [pt1 pt2] = lineSegment_getPointsFromDescriptor(descriptor)
%LINESEGMENT_GETSTARTpt2SFROMDESCRIPTOR Descriptor of 2D line segment (center/orientation/length) from its ending points.
%   DESCRIPTOR = LINESEGMENT_GETDESCRIPTORFROMPOINTS(PT1, PT2) returns the
%   ending points of a 2D line segment, given its 1x4 vector description
%   (center/orientation/length).
%
%   The orientation is given as an angle, in radians, in [o, pi[.
%
%   Also works with several segments at a time (DESCRIPTOR is Nx4,
%   PT1/PT2 are Nx2).

%   Author: Damien Teney

assert(size(descriptor, 2) == 4);
nLineSegments = size(descriptor, 1);

% Empty initialization
pt1 = zeros(nLineSegments, 2);
pt2   = zeros(nLineSegments, 2);

pt1(:, 1:2) = descriptor(:, 1:2) + 0.5 * [descriptor(:, 4).*cos(descriptor(:, 3)) descriptor(:, 4).*sin(descriptor(:, 3))];
pt2(:, 1:2) = descriptor(:, 1:2) - 0.5 * [descriptor(:, 4).*cos(descriptor(:, 3)) descriptor(:, 4).*sin(descriptor(:, 3))];
