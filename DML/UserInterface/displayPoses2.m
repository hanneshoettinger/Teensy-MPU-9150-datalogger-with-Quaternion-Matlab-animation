function displayPoses2(poses, newFigure, markerStyle)
%DISPLAYPOSES2 Visualize 3D poses (alternative version).
%   DISPLAYPOSES2(POSES, NEWFIGURE, MARKERSTYLE) displays the given 3D poses
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

  % Draw a sphere around the origin
  subplot(1, 2, 1);
  axis([-1 1 -1 1 -1 1]); axis equal vis3d; hold on; % Set up axis limits
  plot3(0, 0, 0, 'k+'); % Put a point at the origin
  displaySpheres([0 0 0], 1); % Draw a sphere around the origin

  % Initialize the axis for the 3D position
  subplot(1, 2, 2);
  axis([-100 0 -50 50 -50 50])
  axis equal square vis3d; hold on;
  % Display the camera center and lookAt/up vectors
  cameraVectorsSize = 20;
  plot3([0 -cameraVectorsSize], [0 0], [0 0], 'k-'); % lookAt vector
  plot3([0 0], [0 0], [0 cameraVectorsSize], 'k-'); % lookAt vector
  plot3(-cameraVectorsSize, 0, 0, 'k^'); % Camera "look at" point
end

if isempty(poses)
  return;
end

% Get points on the sphere that correspond to each quaternion
% Empty initializations
points = zeros(size(poses, 1), 3);
for i = 1:size(poses, 1) % For each quaternion
  [qAxis qAngle] = q_getEulerAxisAngle(poses(i, 4:7));
  %radius = qAngle;
  radius = (sin(qAngle) - qAngle) / (-2 * pi);
  points(i, 1:3) = qAxis(1:3) * radius;
end

% Display the points
subplot(1, 2, 1);
plot3([points(:, 1)], ...
      [points(:, 2)], ...
      [points(:, 3)], markerStyle);

subplot(1, 2, 2);
plot3([poses(:, 3)], ...
      [poses(:, 1)], ...
      [poses(:, 2)], markerStyle);
