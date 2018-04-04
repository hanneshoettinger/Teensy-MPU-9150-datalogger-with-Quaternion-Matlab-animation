function result = isPointInsideHtmTriangle(pt, corner0, corner1, corner2)
%ISPOINTINSIDEHTMTRIANGLE Test if a point is inside a HTM triangle.
%   RESULT = ISPOINTINSIDEHTMTRIANGLE(PT, CORNER0, CORNER1, CORNER2)

%   Author: excerpt from the HTM (http://www.skyserver.org/htm), modified
%   by Damien Teney

crossProduct = cross(corner0, corner1);
if dot(crossProduct, pt) < -eps
  result = false;
  return;
end

crossProduct = cross(corner1, corner2);
if dot(crossProduct, pt) < -eps
  result = false;
  return;
end

crossProduct = cross(corner2, corner0);
if dot(crossProduct, pt) < -eps
  result = false;
  return;
end

result = true;
