function rectifiedImage = undistortImage_color(image, cameraCalibration)
%UNDISTORTIMAGE_COLOR Undistort a color image for radial distortion.
%   RECTIFIEDIMAGE = UNDISTORTIMAGE_COLOR(IMAGE, CAMERACALIBRATION)
%   undistorts a color image (MxNx3 matrix) for radial distortion.
%
%   CAMERACALIBRATION must contain the following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)
%     CAMERACALIBRATION.DISTORTION_COEFICIENTS (1x5)
%     CAMERACALIBRATION.IMAGE_WIDTH
%     CAMERACALIBRATION.IMAGE_HEIGHT


%   Author: Damien Teney

% Check the arguments
assert(size(image, 3) == 3); % 3 channels

rectifiedImage = zeros(size(image));

% Undistort each channel of the image
rectifiedImage(:, :, 1) = undistortImage_grayscale(image(:, :, 1), cameraCalibration);
rectifiedImage(:, :, 2) = undistortImage_grayscale(image(:, :, 2), cameraCalibration);
rectifiedImage(:, :, 3) = undistortImage_grayscale(image(:, :, 3), cameraCalibration);

% Cast output to uint8
% (should not be needed since xxx_grayscale already does it (?))
rectifiedImage = uint8(rectifiedImage);
