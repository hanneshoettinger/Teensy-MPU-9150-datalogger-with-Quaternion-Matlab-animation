function displayVectors3(v)
%DISPLAYVECTORS3 Visualize unit 3-vectors.
%   DISPLAYVECTORS3(V) displays the unit 3-vectors contained in V (Nx3
%   matrix) and describing orientations on the 2-sphere.

%   Author: Damien Teney

figure(); axis([-2 2 -2 2 -2 2]); axis equal vis3d; hold on;

% Put a point at the origin
plot3(0, 0, 0, 'k.');

lineStart = [0 0 0];
orientationLineLength = 1;

for i = 1:size(v, 1)
  % Orientation line in X orientation
  lineEnd = orientationLineLength * v(i, :);
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'r-');
end
