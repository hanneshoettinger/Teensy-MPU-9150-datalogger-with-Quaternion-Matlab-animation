Damien's Matlab library
Library of general purpose functions

No guarantees whatsoever provided on the functionnalities/quality of the code.
If reusing the code, please acknowledge the author(s) mentionned in the original code.

Author:
  Damien Teney
  University of Liege, Belgium
  damien.teney@ulg.ac.be
  http://www.montefiore.ulg.ac.be/~dteney/

---------------------------------------------------------------------------

Contents of the library:

/Color/                               Color manipulation.
  colorNames.mat                        
  getColorDistance.m                    Distance measure between two RGB colors.
  getColorNameFromRGB.m                 Standard color name from RGB value/image.
  getNormalizedColorDistance.m          Luminosity-independant distance measure between two RGB colors.
  getRGBFromColorName.m                 RGB value from standard color name.

/Demos/                               Demos of various functions of the library.
  demo_angles_VM.m                      Demo of the von Mises distribution.
  demo_angles_antipodalVM.m             Demo of the von Mises distribution.
  demo_bins_q.m                         Demo of the partitioning of the 3-sphere (unit quaternions).
  demo_bins_v3.m                        Demo of the partitioning of the 2-sphere (unit 3-vectors).
  demo_clustering.m                     Demo of clustering.
  demo_clustering.mat                   
  demo_colorNames.jpg                   
  demo_colorNames.m                     Demo of color naming.
  demo_display.m                        Demo of the display of various 2D and 3D shapes.
  demo_edgeLines.m                      Demo of the detection/deletion/selection of lines in edge maps.
  demo_extractCorners.bmp               
  demo_extractCorners.m                 Demo of a corner detector.
  demo_extractEdgePoints.m              Demo of extraction of points along edges.
  demo_gaussianProcesses.m              Demo of regression using Gaussian processes.
  demo_gaussianProcesses2.m             Demo of regression using Gaussian processes with 2D/1D input/output.
  demo_gaussianProcesses3.m             Demo of regression using Gaussian processes with 1D/2D input/output.
  demo_hopf.m                           Demo of Hopf's axis/angle representation of quaternions.
  demo_inverseFunction.m                Demo of the approximation of the inverse of a function.
  demo_linesClosestPoints.m             Demo of the closests points of 2 3D lines.
  demo_meanRotationError.m              Demo of the mean error on rotation.
  demo_nearestNeighbours1.m             Demo of nearest neighbours (specified number of neighbours).
  demo_nearestNeighbours2.m             Demo of nearest neighbours (specified limit on the distance).
  demo_projectPointOnLine.m             Demo of the projection of a 3D point on a line.
  demo_quaternionAverage.m              Demo of the averaging of quaternions.
  demo_quaternion_VMFDensity.m          Demo of the estimation of density in von Mises-Fisher distribution on S3.
  demo_quaternion_VMFSampling.m         Demo of the sampling of a von Mises-Fisher distribution on the 2-sphere.
  demo_quaternionsRandom.m              Demo of random quaternions.
  demo_rotate2DPoint.m                  Demo of rotation of a 2D point.
  demo_triangularDistribution.m         Demo of the multivariate triangular distribution.
  demo_undistort.m                      Demo of the undistortion of an image.
  demo_undistort.png                    
  demo_vector3_VMFDensity.m             Demo of the estimation of density in von Mises-Fisher distribution on S2.
  demo_vector3_VMFSampling.m            Demo of the sampling of a von Mises-Fisher distribution on the 2-sphere.
  demo_weightedRandomNumbers.m          Demo of sampling of weighted random numbers.

/DmlMex/                              MEX code (C code), mostly duplicates of other (Matlab) functions of the library.
  compileMexCode.m                      Compile specified (user's) MEX files.
  geometry.h                            
  misc.h                                
  q.h                                   
  statistics.h                          
  v3.h                                  

/FileIO/                              File input/output.
  loadCSV.m                             Load 2D matrix from CSV file.
  loadCoViS2DEdges.m                    Load CoViS 2D edge primitives.
  loadCoViS3DEdges.m                    Load CoViS 3D edge primitives.
  loadCoViS3DTextlets.m                 Load CoViS 3D textlet primitives.
  saveCSV.m                             Save 2D matrix to CSV file.
  saveCoViS2DEdges.m                    Save CoViS 2D edge primitives.
  saveCoViS3DEdges.m                    Save CoViS 3D edge primitives.

/GaussianProcesses/                   Regression with Gaussian processes; mostly simplified/documented code from www.gaussianprocess.org/gpml/.
  gp_makePrediction.m                   Gaussian process prediction (with zero mean).

/Geometry/                            Geometry in 2D and in 3D.
  fitPlaneToPoints.m                    Plane fit to 3D points.
  getAngleDifference.m                  Difference between two angles.
  getAngleDifference_half.m             Difference between two angles in [0, pi[.
  getAngleFromSinCos.m                  Angle from sine and cosine.
  getBinaryImageWithLine.m              Create binary image with a line.
  getCentralPointsInPointCloud.m        Identify central points in 3D point cloud.
  getCirclePoints.m                     Equally spaced 2D points on a circle.
  getK.m                                Camera calibration matrix from its intrinsic parameters.
  getLinesClosestPoints.m               Closest points on 2 lines (3D; can be skew or intersecting).
  getLinesClosestPoints2.m              Closest points on 2 lines (3D; can be skew or intersecting; alternative algorithm).
  getMiddlePoint.m                      Middle of segment defined by 2 points.
  getOrientationFrom2DPoints.m          Angle of line defined by 2 points.
  getOrientationFrom3DPoints.m          Orientation of line defined by 3D points.
  getP.m                                Camera projection matrix.
  getPointCloudCenterOfGravity.m        Center of gravity of 3D point cloud.
  getPointCloudRadius.m                 Radius of 3D point cloud.
  getPointLineDistance.m                Distance from point to line (3D).
  getPointSegmentDistance.m             Distance from point to line segment (3D).
  getRandomPointOnLine.m                Random point on a line segment (2D or 3D).
  lineSegment_getDescriptorFromPoints.m  Descriptor of 2D line segment (center/orientation/length) from its ending points.
  lineSegment_getPointsFromDescriptor.m  Descriptor of 2D line segment (center/orientation/length) from its ending points.
  projectPoint.m                        Camera projection of a 3D point.
  projectPoint2.m                       Project a 3D point onto image plane, using given camera calibration.
  projectPointOnLine.m                  Project point on line.
  rotate2DPoint.m                       Rotate 2D point.

/ImageAcquisition/                    Image capture/acquisition.
  initImageAcquisition.m                Initialize image acquisition.

/ImageProcessing/                     Low-level image processing.
  drawLineInMatrix.m                    Draw line in 2D matrix.
  extractCorners.m                      Coner detection in image.
  extractEdgePoints.m                   Extraction of points along edges in image.
  getEdgeMap.m                          Find edges in RGB image.
  getRasterLineCoordinates.m            Coordinates of raster line.
  keepEdgeLines.m                       Detection/selection of lines in edge map.
  removeEdgeLines.m                     Detection/deletion of lines in edge map.
  sift_extractFeatures.m                Extract SIFT features.
  sift_getDistance.m                    Euclidean distance between SIFT descriptors.
  sift_license.txt                      
  sift_linux                            
  sift_match.m                          Demo of matching of SIFT features.
  sift_win32.exe                        
  undistortImage_color.m                Undistort a color image for radial distortion.
  undistortImage_grayscale.m            Undistort a grayscale image for radial distortion.

/Misc/                                Misc functions.
  approximateInverseFunction.m          Approximation of the inverse of a function.
  boundValue.m                          Enforce bounds on a number given min and max limits.
  expandVector.m                        Replicate elements of a 1D vector.
  findKNearestNeighbours.m              Linear k-nearest neighbour (KNN) search.
  findNearestNeighbours.m               Linear nearest neighbour (KNN) search, with limit on the distance.
  getBareDirectoryName.m                Remove the path from a directory name.
  getBareFileName.m                     Remove the path/extension from a file name.
  getHysteresisThresholdedMap.m         Hysteresis thresholding.
  getMatrixLocalMaxima.m                Non maximum suppression.
  getMatrixLocalMaxima2.m               Non maximum suppression.
  getNormOfRows.m                       Norm of each row of a matrix.
  getRandomIndices.m                    Random indices without repetition.
  isAlmostEqual.m                       True if arrays are numerically close.
  launchInteractiveDebug.m              Matlab prompt, with a single variable (given) variable in the workspace; convenient debugging for calling from a MEX file, for example.
  maxOfMatrix.m                         Maximum element of entire matrix.
  minOfMatrix.m                         Minimum element of entire matrix.
  padMatrixEdges.m                      Pad matrix edges with zeros.
  rad2deg.m                             Convert angles from radians to degrees.
  removeMatrixRows.m                    Remove rowd randomly from a given matrix.
  replicateVector.m                     Replicate elements of a 1D vector.
  sub2ind_ignoreBounds.m                Linear index from multiple subscripts (out of bounds inputs generate indices equal to 1).
  unpadMatrixEdges.m                    Remove matrix edges.

/Poses/                               Manipulation of 3D poses (3D position and quaternion for 3D orientation).
  p_concatenate.m                       Concatenate two 3D poses.
  p_getAverage.m                        Average (approximation) of several 3D poses.
  p_getDifference.m                     Difference between two 3D poses.
  p_getFromTransformationMatrix.m       3D Pose from transformation matrix.
  p_getInverse.m                        Inverse of 3D pose.
  p_getWorldSpaceFromImageSpace.m       Transform 3D pose "image space" to "world space".
  p_transformPoints.m                   Set 3D points in a given 3D pose.

/Quaternions/                         Manipulation of unit length quaternions, representing orientations on the 3-sphere.
  q_getAngleDifference.m                Shortest angle between quaternions.
  q_getAverage.m                        Average (approximation) of several quaternions.
  q_getConj.m                           Quaternion conjugate.
  q_getEulerAngles.m                    Euler angles from quaternion.
  q_getEulerAxisAngle.m                 Quaternion to Euler's axis/angle representation.
  q_getFromEulerAngles.m                Quaternion from Euler angles.
  q_getFromEulerAxisAngle.m             Quaternion from Euler's axis/angle representation.
  q_getFromHopfAxisAngle.m              Quaternion from Hopf's axis/angle representation.
  q_getFromRotationMatrix.m             Quaternion from rotation matrix.
  q_getFromTwoVectors3.m                Quaternion from two 3-vectors.
  q_getHopfAxisAngle.m                  Quaternion to Hopf's axis/angle representation.
  q_getInv.m                            Inverse of quaternion.
  q_getPdf_VMF.m                        Probability in von Mises-Fisher distribution.
  q_getPdf_VMFApproximation.m           Approximation of Q_GETPDF_VMF().
  q_getPdf_antipodalVMF.m               Probability in a pair of antipodal von Mises-Fisher distributions.
  q_getPositive.m                       Equivalent positive quaternion.
  q_getRandom.m                         Uniformly distributed unit quaternion.
  q_getRandom_VMF.m                     Random quaternion from von Mises-Fisher distribution.
  q_getRotationBetweenVectors.m         Shortest rotation from one vector onto another.
  q_getRotationMatrix.m                 Transform quaternion to rotation matrix.
  q_getSquaredModulus.m                 Squared modulus of a quaternion.
  q_getTwoVectors3.m                    Quaternion to 2 (orthogonal, unit length) 3-vectors.
  q_getUnit.m                           Unit quaternion.
  q_mult.m                              Multiplication of two quaternions.
  q_rotatePoint.m                       Point rotation.

/SpacePartitioning/                   Partitioning of space into bins; can be used, eg., for creating histograms.
  getBinIndex.m                         Bin index from a scalar.
  pose_getBinIndex.m                    Bin index from 3D pose.
  q_getBinCenter.m                      Bin center from its index.
  q_getBinCount.m                       Number of bins at a given resolution.
  q_getBinIndex.m                       Bin index from unit quaternion.
  q_getBinLimits.m                      Bin limits from its index.
  q_getUniformGrid.m                    Uniformely distributed grid of points on the 3-sphere.
  v3_getBinCenter.m                     Bin center from its index.
  v3_getBinCount.m                      Number of bins at a given resolution.
  v3_getBinIndex.m                      Bin index from (unit length) 3-vector.
  v3_getBinLimits.m                     Bin limits from its index.
  v3_getUniformGrid.m                   Uniformely distributed grid of points on the 2-sphere.
  v_getBinIndex.m                       Bin index from a vector.

/Statistics/                          Statistical functions and clutering.
  clusterDataEM.m                       Clustering by expectation maximization algorithm.
  clusterDataEMAuto.m                   Clustering with automatic number of clusters.
  getPdf_VM.m                           Probability in von Mises distribution.
  getPdf_antipodalVM.m                  Probability in a pair of antipodal von Mises distributions.
  getPdf_circularTriangular.m           Probability in circular isotropic triangular kernel.
  getPdf_triangular.m                   Probability in isotropic triangular kernel.
  getRandomBoolean.m                    Random boolean value.
  getRandomInteger_uniform.m            Random integers in uniform distribution.
  getRandomInteger_weighted.m           Weighted random integers.
  getRandom_triangular.m                Random numbers in triangular distribution.
  getRandom_uniform.m                   Random numbers in uniform distribution.

/UserInterface/                       Display of plots/geometrical shapes, and retrieval of user input.
  currentViewpoint.m                    Save/restore camera parameters in current figure.
  displayCamera.m                       Display a 3D representation of a camera.
  displayCircles.m                      Display 2D circles.
  displayColoredPoints2D.m              Plot colored 2D points.
  displayColoredPoints3D.m              Plot colored 3D points.
  displayDiscs.m                        Display 3D discs.
  displayEllipses.m                     Display 2D ellipses.
  displayEllipsoids.m                   Display 3D ellipsoids.
  displayEmpty2DFigure.m                Display an empty 2D figure.
  displayEmpty3DFigure.m                Display an empty 3D figure.
  displayHorizontalBar2D.m              Horizontal bar in 2D plot.
  displayOrientedPoints2D.m             Plot oriented 2D points.
  displayOrientedPoints3D.m             Plot oriented 3D points.
  displayPoses.m                        Visualize 3D poses.
  displayPoses2.m                       Visualize 3D poses (alternative version).
  displayQuaternions.m                  Visualize quaternions.
  displaySpheres.m                      Display 3D spheres.
  displayVectors3.m                     Visualize unit 3-vectors.
  displayVerticalBar2D.m                Vertical bar in 2D plot.
  displayVerticalBar3D.m                Vertical bar in 3D plot.
  getColor.m                            Random color.
  getUserValue_boolean.m                Let the user enter a yes/no value.
  getUserValue_number.m                 Let the user enter an numerical value.
  linkAllFigures.m                      Link properties of all open figures.
  maximizeFigure.m                      Maximize figure to fill the entire screen.
  printf.m                              Same as fprintf, but outputs to stdout.
  printfLine.m                          Display a separating line with printf().
  select2DPoints.m                      Interactively select 2D points in the current figure.
  select3DPoints.m                      Interactively select 3D points in the current figure.
  selectDirectory.m                     Let the user select a directory.
  selectFileToOpen.m                    Let the user select a file to open.
  selectFileToSave.m                    Let the user select a file to save.
  setHistogram3AutoColors.m             Set automatic colors for a HIST3() figure.

/Vectors3/                            Manipulation of unit length 3-vectors, representing orientations on the 2-sphere.
  v3_getAngleBetweenVectors.m           Angle between 3-vectors.
  v3_getAngleBetweenVectors_undirected.m  Angle between undirected 3-vectors.
  v3_getEulerAngles.m                   Euler angle of an orientation on the 2-sphere.
  v3_getFromEulerAngles.m               Orientation on the 2-sphere from its Euler angles.
  v3_getOrthogonalOnes.m                Two orthogonal 3-vectors to a given one.
  v3_getPdf_VMF.m                       Probability in von Mises-Fisher distribution (2-sphere).
  v3_getPdf_antipodalVMF.m              Probability in pair of antipodal von Mises-Fisher distributions (2-sphere).
  v3_getRandom.m                        Random unit 3-vectors, uniformly distributed on the 2-sphere.
  v3_getRandom_VMF.m                    Random unit 3-vector from von Mises-Fisher distribution.
  v3_getRandom_antipodalVMF.m           Random unit 3-vector from pair of antipodal von Mises-Fisher distributions.
  v3_getUnit.m                          Normalize 3-vector.

functionIndex.htm                     
generateHTMLIndex.m                   Generate HTML code with list of functions of the library.
generateReadme.m                      Generate readme file with list of functions of the library.
generateZipFile.m                     Generate ZIP file of the library.
getDmlDirectory.m                     Path to the directory containing the DML.

---------------------------------------------------------------------------
