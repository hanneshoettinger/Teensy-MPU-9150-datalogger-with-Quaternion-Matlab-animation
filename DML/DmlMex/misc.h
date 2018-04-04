// misc.h
// Misc code (Matlab MEX file)
// Author: Damien Teney

#ifndef DMLMEX_MISC_H
#define DMLMEX_MISC_H

#include <mex.h>
#include <time.h>

#ifndef INLINE
  #define INLINE __forceinline
#endif

#ifndef PI
  #define PI 3.1415926535
#endif

//=========================================================================
// Display a message and terminate the script
//=========================================================================
INLINE void throwError(const char *message) {
  mexErrMsgTxt(message);
}

//=========================================================================
// Display a message
//=========================================================================
INLINE void throwWarning(const char *message) {
  mexWarnMsgTxt(message);
}

//=========================================================================
// Flush output stream of the mexPrintf() function
//=========================================================================
INLINE void flushPrintf(void) {
  mexEvalString("drawnow;");
}

//=========================================================================
// Absolute value
//=========================================================================
INLINE double getAbsoluteValue(double x) {
  return (x >= 0) ? x : -x;
}

//=========================================================================
// Quick rounding for positive numbers
//=========================================================================
INLINE int quickRound(double x) {
  return (int) (x + 0.5);
}

//=========================================================================
// Minimum and maximum
//=========================================================================
//INLINE double min(double a, double b)
INLINE double min(double a, double b) { return (a < b) ? a : b; }
INLINE double max(double a, double b) { return (a > b) ? a : b; }

//=========================================================================
// Conversion between radians and degrees
//=========================================================================
#define RAD2DEG(x) ((double) 180.0 * ((double) x / PI))
#define DEG2RAD(x) ((double) x * (PI / 180.0))

//=========================================================================
// Transpose a matrix
//=========================================================================
INLINE void transposeMatrix(
  // Input
  const double *m,                                  // Size: MxN
  int nRows, int nColumns,                          // Scalars
  // Output
  double *output                                    // Size: NxM
) {
  int i, j;
  for (j = 0; j < nColumns; j++)
    for (i = 0; i < nRows; i++)
      output[i*nColumns + j] = m[j*nRows + i];
}

//=========================================================================
// Compute 3x3 matrix determinant
//=========================================================================
INLINE double get3MatrixDeterminant(
  // Input
  const double *m                                   // Size: 3x3
) {
  // Rename the elements of the input matrix for easier reuse
  const double a = m[0], b = m[1], c = m[2];
  const double d = m[3], e = m[4], f = m[5];
  const double g = m[6], h = m[7], k = m[8];

  const double determinant = a * (e * k - f * h)
                           + b * (f * g - k * d)
                           + c * (d * h - e * g);

  return determinant;
}

//=========================================================================
// Compute inverse of 3x3 matrix
//=========================================================================
INLINE void get3MatrixInverse(
  // Input
  const double *m,                                  // Size: 3x3
  // Output
  double *output                                    // Size: 3x3
) {
  // For algorithm, see http://en.wikipedia.org/wiki/Invertible_matrix

  // Rename the elements of the input matrix for easier reuse
  const double a = m[0], b = m[1], c = m[2];
  const double d = m[3], e = m[4], f = m[5];
  const double g = m[6], h = m[7], k = m[8];
  const double determinant = a * (e * k - f * h)
                           + b * (f * g - k * d)
                           + c * (d * h - e * g);

  // Get the inverse matrix
  output[0] = (e * k - f * h) / determinant;
  output[1] = (c * h - b * k) / determinant;
  output[2] = (b * f - c * e) / determinant;

  output[3] = (f * g - d * k) / determinant;
  output[4] = (a * k - c * g) / determinant;
  output[5] = (c * d - a * f) / determinant;

  output[6] = (d * h - e * g) / determinant;
  output[7] = (b * g - a * h) / determinant;
  output[8] = (a * e - b * d) / determinant;
}

//=========================================================================
// Display matrix of doubles (stored in row-major indexing)
//=========================================================================
void displayMatrix(const double *m, int nRows, int nColumns) {
  int i;

  mexPrintf("Displaying matrix of size %dx%d:\n", nRows, nColumns);

  for (i = 0; i < nRows * nColumns; i++) {
    mexPrintf("%4.2f ", m[i]);
    if ((i + 1) % nColumns == 0)
      mexPrintf("\n");
  }
  mexPrintf("\n\n");
}

//=========================================================================
// Access to global variable (scalars only)
// Warning: very slow
//=========================================================================
double getGlobalVariable(const char *variableName) {
  double value;
  mxArray *arrayPtr = mexGetVariable("global", variableName);
  if (!arrayPtr)
    mexErrMsgTxt("Tried to access a global variable that is not defined.");

  value = mxGetScalar(arrayPtr); // Read the value

  mxDestroyArray(arrayPtr);

  return value;
}

//=========================================================================
// Arc cosine, handles values out of [-1,1] (that can happen due to numerical errors)
//=========================================================================
INLINE double acos_safe(double x) {
  if (x > 1.0) {
    //mexPrintf("\tWarning: x=%f   acos(x)=%f   acos_safe(x)=%f\n", x, acos(x), 0.0); // Debug display
    return 0.0;
  }
  if (x < -1.0) {
    //mexPrintf("tWarning: x=%f   acos(x)=%f   acos_safe(x)=%f\n", x, acos(x), PI); // Debug display
    return PI;
  }
  return acos(x);
}

//=========================================================================
// Wait for a keypress from the user
//=========================================================================
INLINE void waitForKeyPress(void) {
  mexPrintf("Press any key to continue...\n");
  mexCallMATLAB(0, NULL, 0, NULL, "pause");
}

//=========================================================================
// Launch an interactive Matlab prompt, with the given matrix available in the workspace (data must be in column-first order, ie Matlab-style)
//=========================================================================
void launchInteractiveDebug_int(int *data, int nRows, int nColumns) {
  int i, j;
  mxArray *matlabMatrix;
  int *contents; // Actual contents of matlabMatrix

  matlabMatrix = mxCreateNumericMatrix(nRows, nColumns, mxINT32_CLASS, mxREAL);

  // Copy the given data in the mxArray
  contents = (int*) mxGetData(matlabMatrix); 
  for (i = 0; i < nRows; i++) // For each row
    for (j = 0; j < nColumns; j++) // For each row
      contents[i + nRows * j] = data[i + nRows * j];

  mexCallMATLAB(0, NULL, 1, &matlabMatrix, "launchInteractiveDebug"); // Launch a custom Matlab function

  mxDestroyArray(matlabMatrix);
}

void launchInteractiveDebug_double(double *data, int nRows, int nColumns) {
  int i, j;
  mxArray *matlabMatrix;
  double *contents; // Actual contents of matlabMatrix

  matlabMatrix = mxCreateNumericMatrix(nRows, nColumns, mxDOUBLE_CLASS, mxREAL);

  // Copy the given data in the mxArray
  contents = (double*) mxGetData(matlabMatrix); 
  for (i = 0; i < nRows; i++) // For each row
    for (j = 0; j < nColumns; j++) // For each row
      contents[i + nRows * j] = data[i + nRows * j];

  mexCallMATLAB(0, NULL, 1, &matlabMatrix, "launchInteractiveDebug"); // Launch a custom Matlab function

  mxDestroyArray(matlabMatrix);
}

//=========================================================================
// Stopwatch, measure and displays the time between two successive calls
//
// Note that it counts CPU time, which may be slower (time sharing wiht
// other processes) or faster (multiple CPU cores) then wall time
//
// If message is equal to 'NULL', reset the stopwatch
//=========================================================================
void callStopWatch(char *message) {
  clock_t currentTime;
  static clock_t timeAtZero = -1; // Time at which the stopwatch was last reset

  currentTime = clock(); // Get current system time

  mexPrintf("\tStopwatch: ");
  if (timeAtZero < 0 || message == NULL) { // First call of the function, or no message given
    mexPrintf("start");
    timeAtZero = currentTime;
  } else {
    mexPrintf("%.1fs elapsed", (double) (currentTime - timeAtZero) / CLOCKS_PER_SEC);
  }

  if (message)
    mexPrintf(" (%s)", message);
  mexPrintf("\n");

  timeAtZero = currentTime; // Reset, after doing all the display, which we don't want to include in the time measured

  flushPrintf();
}

#endif
