function displayDiscs(centers, radiuses, orientations)
%DISPLAYDiscs Display 3D discs.
%   DISPLAYDISCS(CENTERS, RADIUSES, ORIENTATIONS) displays flat discs of
%   given centers (Nx2 matrix), radiuses (1xN vector) and orientations
%   (3-vectors in a Nx3 matrix). A [1 0 0] orientation
%   corresponds to a disc laying on the YZ plane.

%   Author: Damien Teney

% Constants
resolution = 8;
color = [0 0 0];
transparency = 0.2;

for i = 1:size(centers, 1)
  center = centers(i, :);
  radius = radiuses(i);
  orientation = q_getRotationBetweenVectors([1 0 0], orientations(i, :));

  % Make r/theta grid
  [r theta] = meshgrid([0 1], ...
                   (pi / 180) * [0:(360/resolution):360]);
  % Get cartesian coordinates
  x = r .* cos(theta);
  y = r .* sin(theta);
  z = zeros(size(x));

  % Rotate to the right orientation
  for j = 1:size(x, 1) % For each point
    pt = [x(j, 2) y(j, 2) z(j, 2)];

    % Set the null rotation (disc on YZ plane)
    pt = q_rotatePoint(pt, q_getFromEulerAxisAngle([0 1 0], pi/2));

    pt = q_rotatePoint(pt, orientation);
    x(j, 2) = pt(1);
    y(j, 2) = pt(2);
    z(j, 2) = pt(3);
  end

  % Plot the disc
  surf(center(1) + x * radius, ...
       center(2) + y * radius, ...
       center(3) + z * radius, ...
       'FaceColor', color, ...
       'LineStyle', 'none', ...
       'FaceAlpha', transparency);
       %'FaceLighting','phong', ...
end

% Enable the shading
%camlight left;
