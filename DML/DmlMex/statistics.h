// statistics.h
// Statistics and proabilities (Matlab MEX file)
// Author: Damien Teney

#ifndef DMLMEX_STATISTICS_H
#define DMLMEX_STATISTICS_H

#include <DmlMex/misc.h>


//=========================================================================
// PDF of Gaussian distribution
// (unnormalized; max at 1)
//=========================================================================
INLINE double getPdf_gaussian_univariate(
  // Input
  double evaluationPoint,                           // Scalar
  double mean,                                      // Scalar
  double distributionRadius
) {
  // distributionRadius = 2 * sigma
  double sigma = distributionRadius / 2;
  return exp(-((evaluationPoint - mean) * (evaluationPoint - mean)) / (2 * sigma * sigma));
}

//=========================================================================
// PDF of triangular distribution
// (unnormalized; max at 1)
//=========================================================================
INLINE double getPdf_triangular_univariate(
  // Input
  double evaluationPoint,                           // Scalar
  double mean,                                      // Scalar
  double distributionRadius
) {
  double distanceToMean, result;

  distanceToMean = getAbsoluteValue(evaluationPoint - mean);

  if (distanceToMean >= distributionRadius) // Special case: out of the kernel
    result = 0;
  else { // Normal case
    result = (distributionRadius - distanceToMean) / distributionRadius;
    //result *= (1 / distributionRadius); // Normalize (height of the triangle)
  }

  return result;
}

INLINE double getPdf_triangular_bivariate(
  // Input
  const double *evaluationPoint,                    // Size: 2
  const double *mean,                               // Size: 2
  double distributionRadius
) {
  double pointMeanVector[2];
  double distanceToMean;

  double result;

  // Get distance from point to mean
  pointMeanVector[0] = evaluationPoint[0] - mean[0];
  pointMeanVector[1] = evaluationPoint[1] - mean[1];
  distanceToMean = pointMeanVector[0] * pointMeanVector[0] + pointMeanVector[1] * pointMeanVector[1];

  if (distanceToMean >= distributionRadius) // Special case: out of the kernel
    result = 0;
  else { // Normal case
    result = (distributionRadius - distanceToMean) / distributionRadius;
    //result *= (1 / distributionRadius); // Normalize (height of the triangle)
  }

  return result;
}

//=========================================================================
// PDF of von Mises distribution
// (unnormalized; max at exp(1) ~= 2.7)
//=========================================================================
INLINE double getPdf_VM(
  // Input
  double alpha,                                     // Scalar
  double mean,                                      // Scalar
  double kappa                                      // Scalar
) {
  //return exp(kappa * cos(alpha - mean)); // Gives very big numbers
  return exp(kappa * cos(alpha - mean) - kappa); // Max == exp(1) ~= 2.7
}

//=========================================================================
// Conversion between the 'kappa' parameter of the von Mises-Fisher distribution and the radius angles
// WARNING: angles in radians !
//=========================================================================
// We have:
//   angle = 2 * acos(dotProduct)
//   and
//   dotProduct = cos(angle / 2)
// The VMF PDF is defined by:
//   PDF = exp(kappa * dotProduct - kappa) // Max at 1
// Let's look for the radius that has a PDF of 0.1:
//   exp(kappa * dotProduct - kappa) = 0.1
//   exp(kappa * cos(angle / 2) - kappa) = 0.1
//   cos(angle / 2) = (log(0.1) + kappa) / kappa
//   angle = 2 * acos((log(0.1) + kappa) / kappa)
#define VMF_KAPPA_TO_RADIUSANGLE(kappa) \
  (2.0 * acos((log(0.1) + (double) kappa) / (double) kappa))

// And the other way around, if we know the angle and we want the corresponding kappa:
//   cos(angle / 2) - 1 = log(0.1) / kappa
//   kappa * (cos(angle / 2) - 1) = log(0.1)
//   kappa = log(0.1) / (cos(angle / 2) - 1)
#define VMF_RADIUSANGLE_TO_KAPPA(angle) \
  (log(0.1) / (cos((double) angle / 2.0) - 1.0))

#endif
