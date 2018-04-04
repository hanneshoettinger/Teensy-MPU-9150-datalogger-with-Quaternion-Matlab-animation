// misc.h
// Misc code (Matlab MEX file)
// Author: Damien Teney

#ifndef DMLMEX_GEOMETRY_H
#define DMLMEX_GEOMETRY_H

#include <DmlMex/v3.h>

//=========================================================================
// Projection of point on line (3D)
//=========================================================================
INLINE void projectPointOnLine(
  // Input
  const double *point,                              // Size: 3
  const double *linePoint1,                         // Size: 3
  const double *linePoint2,                         // Size: 3
  // Output
  double *projectedPoint                            // Size: 3
) {
  double v[3], u[3];
  double vNorm, dotProduct;

  // v = linePoint2 - linePoint1;
  V3_DIFFERENCE(v, linePoint2, linePoint1);
  // Normalize it
  vNorm = V3_NORM(v);
  v[0] = v[0] / vNorm;
  v[1] = v[1] / vNorm;
  v[2] = v[2] / vNorm;

  // v = linePoint2 - linePoint1;
  V3_DIFFERENCE(u, point, linePoint1);

  dotProduct = V3_DOT_PRODUCT(u, v);
  projectedPoint[0] = linePoint1[0] + dotProduct * v[0];
  projectedPoint[1] = linePoint1[1] + dotProduct * v[1];
  projectedPoint[2] = linePoint1[2] + dotProduct * v[2];
}

//=========================================================================
// Distance from point to line (3D)
//=========================================================================
INLINE double getPointLineDistance(
  // Input
  const double *point,                              // Size: 3
  const double *linePoint1,                         // Size: 3
  const double *linePoint2                          // Size: 3
) {
  double tmp1[3], tmp2[3], crossProduct[3];
  double distance;

  // tmp1 = linePoint2 - linePoint1;
  V3_DIFFERENCE(tmp1, linePoint2, linePoint1);

  // tmp2 = linePoint1 - point;
  V3_DIFFERENCE(tmp2, linePoint1, point);

  // distance = norm(cross(tmp1, tmp2)) / norm(tmp1);
  V3_CROSS_PRODUCT(crossProduct, tmp1, tmp2);
  distance = V3_NORM(crossProduct) / V3_NORM(tmp1);

  return distance;
}

#endif
