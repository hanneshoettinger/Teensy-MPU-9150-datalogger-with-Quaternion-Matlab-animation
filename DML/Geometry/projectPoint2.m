function projection = projectPoint2(point, cameraCalibration)
% PROJECTPOINT  Project a 3D point onto image plane, using given camera calibration.
%   PROJECTION = PROJECTPOINT(POINT, CAMERACALIBRATION) projects a point
%   (1x3) to the image plane using the specified camera calibration.
%   PROJECTION is a 1x2 vector.
%
%   This function can be numerically more precise thant PROJECTPOINT().
%
%   CAMERACALIBRATION must contain the following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)
%     CAMERACALIBRATION.CAMERA_POSE (1x7: position (3) and orientation
%     quaternion (4))

cameraPoseInverse = p_getInverse(cameraCalibration.CAMERA_POSE);

point = cameraPoseInverse(1:3) + q_rotatePoint(point, cameraPoseInverse(4:7)); % Adjust the 3D point for camera pose

K = getK(cameraCalibration);

projectionHomogeneous = K * [1 0 0 0; 0 1 0 0; 0 0 1 0] * [point(:) ; 1];

projection = zeros(1, 2);
projection(1) = projectionHomogeneous(1) / projectionHomogeneous(3);
projection(2) = projectionHomogeneous(2) / projectionHomogeneous(3);
