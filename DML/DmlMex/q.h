// q.h
// Operations on Quaternions (Matlab MEX file)
// Author: Damien Teney

#ifndef DMLMEX_Q_H
#define DMLMEX_Q_H

#include <dmlMex/misc.h>
#include <dmlMex/v3.h>

//=========================================================================
// Basic operations
//=========================================================================
#define Q_NORM(a) \
  sqrt((a)[0] * (a)[0] + (a)[1] * (a)[1] + (a)[2] * (a)[2] + (a)[3] * (a)[3])

#define Q_DOT_PRODUCT(q1, q2) \
  ((q1)[0] * (q2)[0] + (q1)[1] * (q2)[1] + (q1)[2] * (q2)[2] + (q1)[3] * (q2)[3])

#define Q_INV(qInv, q); \
  (qInv)[0] =  (q)[0]; \
  (qInv)[1] = -(q)[1]; \
  (qInv)[2] = -(q)[2]; \
  (qInv)[3] = -(q)[3];

#define Q_MULTIPLICATION(q, q1, q2); \
  (q)[0] = (q1)[0]*(q2)[0] - (q1)[1]*(q2)[1] - (q1)[2]*(q2)[2] - (q1)[3]*(q2)[3]; \
  (q)[1] = (q1)[0]*(q2)[1] + (q1)[1]*(q2)[0] + (q1)[2]*(q2)[3] - (q1)[3]*(q2)[2]; \
  (q)[2] = (q1)[0]*(q2)[2] - (q1)[1]*(q2)[3] + (q1)[2]*(q2)[0] + (q1)[3]*(q2)[1]; \
  (q)[3] = (q1)[0]*(q2)[3] + (q1)[1]*(q2)[2] - (q1)[2]*(q2)[1] + (q1)[3]*(q2)[0];

//=========================================================================
// Point rotation
//=========================================================================
INLINE void q_rotatePoint(
  // Input
  const double *point,                              // Size: 3
  const double *q,                                  // Size: 4
  // Output
  double *rotatedPoint                              // Size: 3
) {
  // Variable declarations
  double Qw, Qi, Qj, Qk;
  double v1, v2, v3;
  double t2, t3, t4, t5, t6, t7, t8, t9, t10;

  // Rename the elements of the parameters
  Qw = q[0];  Qi = q[1];  Qj = q[2];  Qk = q[3];
  v1 = point[0];  v2 = point[1];  v3 = point[2];

  // Perform the computations
  t2 =   Qw * Qi;
  t3 =   Qw * Qj;
  t4 =   Qw * Qk;
  t5 =  -Qi * Qi;
  t6 =   Qi * Qj;
  t7 =   Qi * Qk;
  t8 =  -Qj * Qj;
  t9 =   Qj * Qk;
  t10 = -Qk * Qk;

  rotatedPoint[0] = 2 * ( (t8 + t10)*v1 + (t6 -  t4)*v2 + (t3 + t7)*v3 ) + v1;
  rotatedPoint[1] = 2 * ( (t4 +  t6)*v1 + (t5 + t10)*v2 + (t9 - t2)*v3 ) + v2;
  rotatedPoint[2] = 2 * ( (t7 -  t3)*v1 + (t2 +  t9)*v2 + (t5 + t8)*v3 ) + v3;
}

//=========================================================================
// Quaternion corresponding to a rotation around the -Z axis
//=========================================================================
INLINE void q_getMinusZAxisRotation(
  // Input
  double angle,                                      // Scalar
  // Output
  double *q                                          // Size: 1 x 4
) {
  q[0] = cos(angle / 2);
  q[1] = 0;
  q[2] = 0;
  q[3] = -sin(angle / 2);
}

//=========================================================================
// Quaternion to Hopf's axis/angle representation
//=========================================================================
void q_getHopfAxisAngle(
  // Input
  const double *q,                                 // Size: 4
  // Output
  double *axis,                                    // Size: 3
  double *angle                                    // Scalar
) {
  double xAxis[3];
  double norm;
  double q2[4], q2Inv[4], q1[4];

  // Do the following operation:
  // axis = q_rotatePoint([1 0 0], q);
  axis[0] = 2.0 * -(q[2]*q[2] + q[3]*q[3]) + 1;
  axis[1] = 2.0 *  (q[0]*q[3] + q[1]*q[2]);
  axis[2] = 2.0 *  (q[1]*q[3] - q[0]*q[2]);

  // Do the following operation:
  // q2 = q_getRotationBetweenVectors([1 0 0], axis);
  if        (axis[0] == 1 && axis[1] == 0 && axis[2] == 0) { // axis == [1 0 0]
    q2[0] = 1; q2[1] = 0; q2[2] = 0; q2[3] = 0;
  } else if (axis[0] == -1 && axis[1] == 0 && axis[2] == 0) { // axis == [-1 0 0]
    throwError("Special case not supported !");
  } else {
    xAxis[0] = 1; xAxis[1] = 0; xAxis[2] = 0;

    // See:
    // http://www.euclideanspace.com/maths/algebra/vectors/angleBetween/index.htm
    // Heavy simplifications are possible since the first vector is [1 0 0]
    q2[0] = 1 + axis[0];
    q2[1] = 0;
    q2[2] = -axis[2];
    q2[3] =  axis[1];

    // Normalize q2
    norm = Q_NORM(q2);
    q2[0] = q2[0] / norm;
    q2[1] = q2[1] / norm;
    q2[2] = q2[2] / norm;
    q2[3] = q2[3] / norm;
  }

  // q1 = q_getInv(q2) * q
  Q_INV(q2Inv, q2);
  Q_MULTIPLICATION(q1, q2Inv, q);

  // q1 is a rotation around [1 0 0], get the angle of that rotation
  // [xAxis angle] = q_getEulerAxisAngle(q1);
  if (q1[1] >= 0)
    *angle = 2.0 * acos_safe(q1[0]);
  else
    *angle = -2.0 * acos_safe(q1[0]) + 2.0 * PI;

  // Debug check
  /*
  xAxis[0] = q1[1] / sqrt(1 - q1[0] * q1[0]);
  xAxis[1] = q1[2] / sqrt(1 - q1[0] * q1[0]);
  xAxis[2] = q1[3] / sqrt(1 - q1[0] * q1[0]);
  if (!(xAxis[0] == 1 && xAxis[1] == 0 && xAxis[2] == 0)) { // We didn't get back the X axis (may fail due to numerical errors)
    mexPrintf("X axis: [%2.1f %2.1f %2.1f]\n]", xAxis[0], xAxis[1], xAxis[2]);
    throwError("q_getHopfAxisAngle failed !");
  }
  */
}

//=========================================================================
// Shortest rotation from one vector onto another
//=========================================================================
INLINE void q_getRotationBetweenVectors(
  // Input
  const double *v1,                                 // Size: 3
  const double *v2,                                 // Size: 3
  // Output
  double *q                                         // Size: 4
) {
  double norm;
  double crossProduct[3];

  if (v1[0] == v2[0] && v1[1] == v2[1] && v1[2] == v2[2]) { // v1 == v2
    // Special case
    q[0] = 1;
    q[1] = 0;
    q[2] = 0;
    q[3] = 0;
  } else if (v1[0] == -v2[0] && v1[1] == -v2[1] && v1[2] == -v2[2]) { // v1 == -v2
    // Special case
    throwError("Special case not handled !");
  } else {
    // See:
    // http://www.euclideanspace.com/maths/algebra/vectors/angleBetween/index.htm
    q[0] = V3_NORM(v1) * V3_NORM(v2) + V3_DOT_PRODUCT(v1, v2);

    V3_CROSS_PRODUCT(crossProduct, v1, v2);
    q[1] = crossProduct[0];
    q[2] = crossProduct[1];
    q[3] = crossProduct[2];

    // Normalize Q
    norm = Q_NORM(q);
    q[0] = q[0] / norm;
    q[1] = q[1] / norm;
    q[2] = q[2] / norm;
    q[3] = q[3] / norm;
  }
}

//=========================================================================
// Quaternion from Euler's axis/angle representation
//=========================================================================
INLINE void q_getFromEulerAxisAngle(
  // Input
  const double *axis,                              // Size: 3
  double angle,                                    // Scalar
  // Output
  double *q                                        // Size: 3
) {
  double axisNorm;
  double axisNormalized[3];

  // Normalize the axis
  axisNorm = V3_NORM(axis);
  axisNormalized[0] = axis[0] / axisNorm;
  axisNormalized[1] = axis[1] / axisNorm;
  axisNormalized[2] = axis[2] / axisNorm;

  q[0] = cos(angle / 2);
  q[1] = axisNormalized[0] * sin(angle / 2);
  q[2] = axisNormalized[1] * sin(angle / 2);
  q[3] = axisNormalized[2] * sin(angle / 2);
}

//=========================================================================
// Shortest angle between quaternions
//=========================================================================
INLINE double q_getAngleDifference(
  // Input
  const double *q1,                                // Size: 4
  const double *q2                                 // Size: 4
) {
  double angle, dotProduct;

  if ((q1[0] ==  q2[0] && q1[1] ==  q2[1] && q1[2] ==  q2[2] && q1[3] ==  q2[3] && q1[4] ==  q2[4])    // q1 ==  q2
  ||  (q1[0] == -q2[0] && q1[1] == -q2[1] && q1[2] == -q2[2] && q1[3] == -q2[3] && q1[4] == -q2[4])) { // q1 == -q2
    // Special case
    return 0;
  } else {
    dotProduct = getAbsoluteValue(Q_DOT_PRODUCT(q1,  q2)); // Take the absolute value to ensure we keep the shortest arc
    angle = 2.0 * acos_safe(dotProduct);
  }

  return angle;
}

//=========================================================================
// PDF of von Mises-Fisher distribution
// (unnormalized; max at exp(0) = 1)
//=========================================================================
INLINE double q_getPdf_VMF(
  // Input
  const double *mu,                                // Size: 4
  const double *q,                                 // Size: 4
  double kappa                                     // Scalar
) {
  double dotProduct;
  dotProduct = Q_DOT_PRODUCT(mu, q);

  return exp(kappa * dotProduct - kappa);
}

#endif
