function pose2 = p_getInverse(pose1)
%P_GETINVERSE Inverse of 3D pose.
%   POSE2 = P_GETINVERSE(POSE1) computes the inverse of a pose (1x7 vector:
%   translation (3), rotation quaternion (4)). In other terms,
%   setting an object to pose1, then to pose2, is equivalent to doing
%   nothing.

%   Author: Damien Teney

% Rotation
pose2(4:7) = q_getInv(pose1(4:7));

% Translation
pose2(1:3) = q_rotatePoint(-pose1(1:3), pose2(4:7));
