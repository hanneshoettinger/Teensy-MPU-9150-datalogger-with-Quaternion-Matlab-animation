function displaySpheres(centers, radiuses)
%DISPLAYSPHERES  Display 3D spheres.
%   DISPLAYSPHERES(CENTERS, RADIUSES) displays spheres of given centers
%   (Nx3 matrix) and radiuses (1xN vector).

%   Author: Damien Teney

% Constants
resolution = 16;
color = [0 0 0];
transparency = 0.2;

for i = 1:size(centers, 1)
  center = centers(i, :);
  radius = radiuses(i);

  % Plot a sphere
  [x y z] = sphere(resolution);
  surf(center(1) + x * radius, ...
       center(2) + y * radius, ...
       center(3) + z * radius, ...
       'FaceColor', color, ...
       'LineStyle', 'none', ...
       'FaceAlpha', transparency);
       %'EdgeColor', 'k', ...
       %'EdgeAlpha', 0.1, ...
       %'FaceLighting','phong', ...
end

% Enable the shading
%camlight left;
