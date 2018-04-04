function K = getK(cameraCalibration)
%GETK Camera calibration matrix from its intrinsic parameters.
%   K = getK(CAMERACALIBRATION) gets the camera calibration matrix K
%   corresponding to the intrinsic calibration parameters.
%
%   CAMERACALIBRATION must contain the following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)

%   Author: Damien Teney

K = [cameraCalibration.FOCAL_LENGTHS(1)                                  0 cameraCalibration.IMAGE_CENTER(1);
                                      0 cameraCalibration.FOCAL_LENGTHS(2) cameraCalibration.IMAGE_CENTER(2);
                                      0                                  0                                 1];
