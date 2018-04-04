function averagePose = p_getAverage(poses)
%P_GETAVERAGE Average (approximation) of several 3D poses.
%   AVERAGEPOSE = P_GETAVERAGE(POSES) computes an average of several 3D
%   poses (Nx7 matrix: position (3), orientation quaternion (4)).

%   Author: Damien Teney

averagePose(1, 1:3) = mean        (poses(:, 1:3)); % Position
averagePose(1, 4:7) = q_getAverage(poses(:, 4:7)); % Orientation
