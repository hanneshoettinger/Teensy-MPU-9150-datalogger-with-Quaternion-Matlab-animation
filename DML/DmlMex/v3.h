// v3.h
// Operations on 3-vectors (Matlab MEX file)
// Author: Damien Teney

#ifndef DMLMEX_V3_H
#define DMLMEX_V3_H

#include <dmlMex/misc.h>

//=========================================================================
// Basic operations
//=========================================================================
#define V3_NORM(a) \
  sqrt((a)[0] * (a)[0] + (a)[1] * (a)[1] + (a)[2] * (a)[2])

#define V3_DOT_PRODUCT(a, b) \
  ((a)[0] * (b)[0] + (a)[1] * (b)[1] + (a)[2] * (b)[2])

#define V3_DIFFERENCE(a, b, c); \
  (a)[0] = (b)[0] - (c)[0]; \
  (a)[1] = (b)[1] - (c)[1]; \
  (a)[2] = (b)[2] - (c)[2];

#define V3_MIDDLE_POINT(a, b, c); \
  (a)[0] = ((b)[0] + (c)[0]) / 2; \
  (a)[1] = ((b)[1] + (c)[1]) / 2; \
  (a)[2] = ((b)[2] + (c)[2]) / 2;

#define V3_CROSS_PRODUCT(a, b, c); \
  (a)[0] = (b)[1] * (c)[2] - (c)[1] * (b)[2]; \
  (a)[1] = (b)[2] * (c)[0] - (c)[2] * (b)[0]; \
  (a)[2] = (b)[0] * (c)[1] - (c)[0] * (b)[1];

#define V3_COPY(dest, orig); \
  (dest)[0] = (orig)[0]; \
  (dest)[1] = (orig)[1]; \
  (dest)[2] = (orig)[2];

//=========================================================================
// Shortest angle between vectors, not taking into account their direction (ie v equialent to -v)
//=========================================================================
INLINE double v3_getAngleBetweenVectors_undirected(
  // Input
  const double *v1,                                // Size: 3
  const double *v2                                 // Size: 3
) {
  double angle, dotProduct;

  if ((v1[0] ==  v2[0] && v1[1] ==  v2[1] && v1[2] ==  v2[2] && v1[3] ==  v2[3])    // v1 ==  v2
  ||  (v1[0] == -v2[0] && v1[1] == -v2[1] && v1[2] == -v2[2] && v1[3] == -v2[3])) { // v1 == -v2
    // Special case
    return 0;
  } else {
    dotProduct = getAbsoluteValue(V3_DOT_PRODUCT(v1, v2)); // Take the absolute value to ensure we keep the shortest arc, not taking into account the direction
    angle = acos_safe(dotProduct);
  }

  return angle;
}

//=========================================================================
// PDF of von Mises-Fisher distribution
// (unnormalized; max at exp(0) = 1)
//=========================================================================
INLINE double v3_getPdf_VMF(
  // Input
  const double *mu,                                // Size: 3
  const double *v,                                 // Size: 3
  double kappa                                     // Scalar
) {
  double dotProduct;
  dotProduct = V3_DOT_PRODUCT(mu, v);

  return exp(kappa * dotProduct - kappa);
}

#endif
