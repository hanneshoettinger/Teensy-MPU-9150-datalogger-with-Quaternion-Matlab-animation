function displayQuaternions(q)
%DISPLAYQUATERNIONS Visualize quaternions.
%   DISPLAYQUATERNIONS(Q) displays the quaternions contained in Q
%   (Nx4 matrix).

%   Author: Damien Teney

figure(); axis([-2 2 -2 2 -2 2]); axis equal vis3d; hold on;

% Put a point at the origin
plot3(0, 0, 0, 'k.');

lineStart = [0 0 0];
lineEnd = [0 0 0];

orientationLineLength = 1;

for i = 1:size(q, 1)
  % Orientation line in X orientation
  lineEnd = q_rotatePoint(orientationLineLength * [1 0 0], q(i, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'r-');

  % Orientation line in Y orientaton
  lineEnd = q_rotatePoint(orientationLineLength * [0 1 0], q(i, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'b-');

  % Orientation line in Z orientaton
  lineEnd = q_rotatePoint(orientationLineLength * [0 0 1], q(i, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'k-');
end
