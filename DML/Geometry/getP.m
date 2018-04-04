function P = getP(cameraCalibration)
%GETP Camera projection matrix.
%   P = GETP(CAMERACALIBRATION) returns the camera projection matrix P 
%   corresponding to the given camera calibration (intrinsic and
%   extrinsic).
%
%   CAMERACALIBRATION must contain the following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)
%     CAMERACALIBRATION.CAMERA_POSE (1x7: position (3) and orientation
%     quaternion (4))

%   Author: Damien Teney

cameraPoseInverse = p_getInverse(cameraCalibration.CAMERA_POSE);
R = q_getRotationMatrix(cameraPoseInverse(4:7));
t = cameraPoseInverse(1:3);

K = getK(cameraCalibration);
P = K * [R t'];
