function points2 = p_transformPoints(points, pose)
%P_TRANSFORMPOINTS Set 3D points in a given 3D pose.
%   POINTS2 = P_TRANSFORMPOINTS(POINTS, POSE) transforms 3D points (Nx3)
%   to a given pose (1x7 vector: translation (3), orientation quaternion
%   (4)). The output is of the same format as the input (Nx3).

%   Author: Damien Teney

points2 = zeros(size(points)); % Initialize output

for i = 1:size(points, 1) % For each point
  point = points(i, 1:3);
  point2 = q_rotatePoint(point, pose(4:7)) + pose(1:3);
  points2(i, 1:3) = point2;
end
