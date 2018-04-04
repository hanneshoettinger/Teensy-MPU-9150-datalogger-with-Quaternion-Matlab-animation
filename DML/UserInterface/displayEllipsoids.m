function displayEllipsoids(centers, covariances)
%DISPLAYELLIPSOIDS Display 3D ellipsoids.
%   DISPLAYELLIPSOIDS(CENTERS, COVARIANCES) displays ellipsoids of given
%   centers (Nx3 matrix) and corresponding to given covariance matrices
%   (reshaped to 1x9 vectors, and thus given in a Nx9 matrix).
%
%   The length of the principal axes of the ellipsoid are equal to 2
%   standard deviations.

%   Author: Damien Teney

% Constants
resolution = 8;
color = [0 0 0];
transparency = 0.2;

for i = 1:size(centers, 1)
  center = centers(i, :);
  covariance = reshape(covariances(i, :), 3, 3); % 3x3 matrix
  [x y z] = sphere(resolution);

  % Extract geometric information from the covariance matrix
  [eigenVectors eigenValues] = eig(covariance);

  radiusX = 2 * sqrt(eigenValues(1, 1));
  radiusY = 2 * sqrt(eigenValues(2, 2));
  radiusZ = 2 * sqrt(eigenValues(3, 3));

  % Rotate to the right orientation
  for u = 1:size(x, 1) % For each point
    for v = 1:size(x, 2) % For each point
      pt = [x(u, v) * radiusX ...
            y(u, v) * radiusY ...
            z(u, v) * radiusZ];
      pt = eigenVectors * pt'; % eigenVectors is a rotation matrix
      x(u, v) = real(pt(1));
      y(u, v) = real(pt(2));
      z(u, v) = real(pt(3));
    end
  end

  % Plot the ellipsoid
  surf(center(1) + x, ...
       center(2) + y, ...
       center(3) + z, ...
       'FaceColor', color, ...
       'LineStyle', 'none', ...
       'FaceAlpha', transparency);
       %'FaceLighting','phong', ...
end

% Enable the shading
%camlight left;
