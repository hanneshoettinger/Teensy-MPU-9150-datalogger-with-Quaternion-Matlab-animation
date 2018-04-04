function figureId = displayCamera(cameraCalibration)
%DISPLAYCAMERA Display a 3D representation of a camera.
%   DISPLAYCAMERA(CAMERACALIBRATION) displays a 3D figure in which a camera
%   is represented as its image plane and its focal center. The camera is
%   specified by the parameters CAMERACALIBRATION, which must contain the
%   following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_WIDTH (1)
%     CAMERACALIBRATION.IMAGE_HEIGHT (1)
%   The camera is supposed to be centered at the origin, and looking in the
%   -Z direction. Matlab's X/Y/Z axis are the world (camera)'s Z/X/Y axis,
%   since this looks better (makes a "horizontal" figure).

%   Author: Damien Teney

figure();
%axis([-100 0 -50 50 -50 50])
axis equal; axis square vis3d; hold on;

%grid on; % Turn on the grid
view(3); % Set oblique viewpoint

% Rename camera parameters for clarity
f = abs(cameraCalibration.FOCAL_LENGTHS(1));
w = cameraCalibration.IMAGE_WIDTH;
h = cameraCalibration.IMAGE_HEIGHT;

% Specify the corners of the image plane
corners = [-w/2 -h/2 -f ; % Lower left
           +w/2 -h/2 -f ; % Lower right
           +w/2 +h/2 -f ; % Upper right
           -w/2 +h/2 -f ]; % Upper left
% Exchange columns to make it look nice as Matlab has the Z axis pointing up
oldX = corners(:, 1);
oldY = corners(:, 2);
oldZ = corners(:, 3);
corners(:, 1) = oldZ;
corners(:, 2) = oldX;
corners(:, 3) = oldY;

% Draw the image plane
plot3([corners(1, 1) corners(2, 1) corners(3, 1) corners(4, 1) corners(1, 1)], ...
      [corners(1, 2) corners(2, 2) corners(3, 2) corners(4, 2) corners(1, 2)], ...
      [corners(1, 3) corners(2, 3) corners(3, 3) corners(4, 3) corners(1, 3)], ...
      'LineWidth', 2, 'Color', 0.3 * [1 1 1]);

% Connect the origin to the image plane
for i = 1:4
  plot3([0 corners(i, 1)], ...
        [0 corners(i, 2)], ...
        [0 corners(i, 3)], ...
        'LineWidth', 1, 'Color', 0.7 * [1 1 1]);
end

%maximizeFigure();
