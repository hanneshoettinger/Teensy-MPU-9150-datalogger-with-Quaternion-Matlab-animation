function v = getOrientationFrom3DPoints(p1, p2)
%GETORIENTATIONFROM3DPOINTS Orientation of line defined by 3D points.
%   V = GETORIENTATIONFROM3DPOINTS(p1, p2) returns the unit 3-vector V
%   (1x3) defining one orientation of the line segment going through the
%   two given points (1x3).

%   Author: Damien Teney

v = v3_getUnit(p2 - p1);
