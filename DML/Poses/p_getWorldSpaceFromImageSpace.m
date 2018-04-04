function poses_worldSpace = p_getWorldSpaceFromImageSpace(poses_imageSpace, cameraCalibration, defaultDistance)
%P_GETWORLDSPACEFROMIMAGESPACE Transform 3D pose "image space" to "world space".
%   POSES_WORLDSPACE = P_GETWORLDSPACEFROMIMAGESPACE(POSES_IMAGESPACE, CAMERACALIBRATION, DEFAULTDISTANCE)
%   transform a 3D pose from "image space" to "world space".
%
%   World space:
%     1:3: [X Y Z] position
%     4:7: orientation quaternion
%
%   Image space:
%     1:3: unit 3-vector of the viewpoint (point on the viewing sphere)
%     4  : rotation in the image plane in radians
%     5:6: [X Y] translation in the image plane
%     7  : scale, a value of 1.0 corresponds to the object at a distance of
%          DEFAULTDISTANCE from the camera center
%
%   CAMERACALIBRATION must contain the following element:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)
%     CAMERACALIBRATION.CAMERA_POSE (1x7)

%   Author: Damien Teney

nPoses = size(poses_imageSpace, 1);
poses_worldSpace = zeros(nPoses, 7);

for i = 1:nPoses % For each given pose
  pose_imageSpace = poses_imageSpace(i, :); % Rename for clarity

  % Check the validity of the input pose
  assert(numel(pose_imageSpace) == 7);
  assert(isAlmostEqual(norm(pose_imageSpace(1:3)), 1));

  %------------------------------------------------------------------------
  % Orientation
  %------------------------------------------------------------------------
  q1 = q_getRotationBetweenVectors(pose_imageSpace(1:3), [0 0 -1]); % Rotation that puts the given side of the object in front of the camera (which is pointing towards +Z)
  q2 = q_getFromEulerAxisAngle([0 0 1], pose_imageSpace(4)); % Rotation in the image plane
  poses_worldSpace(i, 4:7) = q_mult(q2, q1); % Concatenate those two rotations

  %------------------------------------------------------------------------
  % Position
  %------------------------------------------------------------------------
  x = pose_imageSpace(5); y = pose_imageSpace(6);
  scale = pose_imageSpace(7);
  tmpVector = [x y abs(cameraCalibration.FOCAL_LENGTHS(1))]; % Vector from the image center to the given observation on the image plane
  tmpVector = tmpVector ./ norm(tmpVector); % Normalize
  tmpVector = tmpVector * defaultDistance; % Set at default distance
  tmpVector = tmpVector * (1 / scale); % Set at given scale
  position = cameraCalibration.CAMERA_POSE(1:3) ... % Camera center
           + q_rotatePoint(tmpVector, cameraCalibration.CAMERA_POSE(4:7)); % Adjust for camera orientation
  poses_worldSpace(i, 1:3) = position;
end
