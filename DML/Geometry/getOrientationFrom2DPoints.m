function angle = getOrientationFrom2DPoints(p1, p2)
%GETORIENTATIONFROM2DPOINTS Angle of line defined by 2 points.
%   ANGLE = GETORIENTATIONFROM2DPOINTS(P1, P2) returns the angle (in
%   radians) between the line going through two 2D points, and the [1 0]
%   vector. The angle is comprised in [-pi/2,pi/2].

%   Author: Damien Teney

angle = atan((p2(2) - p1(2)) / (p2(1) - p1(1)));
