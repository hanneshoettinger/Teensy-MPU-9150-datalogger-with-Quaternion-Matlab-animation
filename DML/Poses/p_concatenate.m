function pose3 = p_concatenate(pose1, pose2)
%P_CONCATENATE Concatenate two 3D poses.
%   POSE3 = P_CONCATENATE(POSE1, POSE2) concatenates two poses (1x7 vector:
%   translation (3), rotation quaternion (4)). In other terms, setting an
%   object to POSE1, then to POSE2, is equivalent to setting it to POSE3.

%   Author: Damien Teney

pose3 = zeros(1,7);

% Translation
pose3(1:3) = q_rotatePoint(pose1(1:3), pose2(4:7));
pose3(1:3) = pose3(1:3) + pose2(1:3);

% Rotation
pose3(4:7) = q_mult(pose2(4:7), pose1(4:7));
