function [translation rotation] = p_getDifference(pose1, pose2)
%P_GETDIFFERENCE Difference between two 3D poses.
%   [TRANSLATION ROTATION] = P_GETDIFFERENCE(POSE1, POSE2) returns the
%   difference in translation and orientation (in radians) between two
%   given poses (1x7 vector: translation (3), rotation quaternion (4)).

%   Author: Damien Teney

if ~isequal(size(pose1), [1 7]) || ~isequal(size(pose2), [1 7])
  error('Invalid arguments.')
end

% Get the difference in translation
translation = norm(pose2(1:3) - pose1(1:3));

% Get the difference in rotation
rotation = q_getAngleDifference(pose1(4:7), pose2(4:7));
