function pose = p_getFromTransformationMatrix(m)
%P_GETFROMTRANSFORMATIONMATRIX 3D Pose from transformation matrix.
%   POSE = P_GETFROMTRANSFORMATIONMATRIX(M) return the pose (1x7 vector:
%    translation (3), rotation quaternion (4)) corresponding to the
%    given transformation matrix (4x4: rotation matrix concatenated with
%    the translation vector).

%   Author: Damien Teney

assert(isequal(m(4, 4), 1)); % Handle only simple transformation matrices (homogeneous factor == 1)

% Extract translation
translationVector = m(1:3, 4);
translationVector = translationVector(:);

% Extract rotation
rotationMatrix = m(1:3, 1:3);
rotationQuaternion = q_getFromRotationMatrix(rotationMatrix);

% Get the result
pose = zeros(1, 7);
pose(1, 1:3) = translationVector(:);
pose(1, 4:7) = rotationQuaternion(:);
