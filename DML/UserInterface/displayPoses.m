function displayPoses(poses, newFigure, markerStyle)
%DISPLAYPOSES Visualize 3D poses.
%   DISPLAYPOSE(POSES, NEWFIGURE, MARKERSTYLE) displays the given 3D poses
%   (Nx7 matrix: position (3) and orientation quaternion (4)).
%
%   A new figure is created only if specified; the last argument is to be
%   formatted as if given to the PLOT() function, eg 'k.' or 'go'.

%   Author: Damien Teney

% Set default values for arguments
if nargin < 2
  newFigure = true;
end
if nargin < 3
  markerStyle = 'k.';
end

% Initialize display
if newFigure
  figure();
  maximizeFigure();

  % Draw unit spheres around the origin
  for subfigureId = 1:3
    subplot(1, 4, subfigureId);

    axis([-1 1 -1 1 -1 1]); axis equal vis3d; hold on; % Set up axis limits
    plot3(0, 0, 0, 'k+'); % Put a point at the origin
    displaySpheres([0 0 0], 1); % Draw a unit sphere around the origin
  end

  % Initialize the axis for the 3D position
  subplot(1, 4, 4);
  axis([-2000 0 -1000 +1000 -1000 +1000])
  axis equal square vis3d; hold on;
  grid on;
  % Display the camera center and lookAt/up vectors
  cameraVectorsSize = 100;
  plot3([0 -cameraVectorsSize], [0 0], [0 0], 'k-'); % "look at" vector
  plot3([0 0], [0 0], [0 cameraVectorsSize], 'k-'); % "up" vector
  plot3(-cameraVectorsSize, 0, 0, 'k^'); % "look at" point
end

if isempty(poses)
  return;
end

% Get points on the sphere that correspond to each quaternion
% Empty initializations
points1 = zeros(size(poses, 1), 3);
points2 = zeros(size(poses, 1), 3);
points3 = zeros(size(poses, 1), 3);
for i = 1:size(poses, 1) % For each quaternion
  points1(i, 1:3) = q_rotatePoint([1 0 0], poses(i, 4:7));
  points2(i, 1:3) = q_rotatePoint([0 1 0], poses(i, 4:7));
  points3(i, 1:3) = q_rotatePoint([0 0 1], poses(i, 4:7));
end

% Display the points
subplot(1, 4, 1);
plot3([points1(:, 1)], ...
      [points1(:, 2)], ...
      [points1(:, 3)], markerStyle);

subplot(1, 4, 2);
plot3([points2(:, 1)], ...
      [points2(:, 2)], ...
      [points2(:, 3)], markerStyle);

subplot(1, 4, 3);
plot3([points3(:, 1)], ...
      [points3(:, 2)], ...
      [points3(:, 3)], markerStyle);

subplot(1, 4, 4);
plot3([-poses(:, 3)], ...
      [-poses(:, 1)], ...
      [-poses(:, 2)], markerStyle);
