function rectifiedImage = undistortImage_grayscale(image, cameraCalibration)
%UNDISTORTIMAGE_GRAYSCALE Undistort a grayscale image for radial distortion.
%   RECTIFIEDIMAGE = UNDISTORTIMAGE_GRAYSCALE(IMAGE, CAMERACALIBRATION)
%   undistorts a grayscale image (MxN matrix) for radial distortion.
%
%   CAMERACALIBRATION must contain the following elements:
%     CAMERACALIBRATION.FOCAL_LENGTHS (1x2)
%     CAMERACALIBRATION.IMAGE_CENTER (1x2)
%     CAMERACALIBRATION.DISTORTION_COEFICIENTS (1x5)
%     CAMERACALIBRATION.IMAGE_WIDTH
%     CAMERACALIBRATION.IMAGE_HEIGHT

%   Author: excerpt from the Camera Calibration Toolbox for Matlab
%   (http://www.vision.caltech.edu/bouguetj/calib_doc/), modified by Damien
%   Teney

% Check the arguments
assert(size(image, 3) == 1); % Only one channel

% Cast input to doubles
image = double(image);

% Rename for clarity
f = cameraCalibration.FOCAL_LENGTHS;
c = cameraCalibration.IMAGE_CENTER;
k = cameraCalibration.DISTORTION_COEFICIENTS;
nc = cameraCalibration.IMAGE_WIDTH;
nr = cameraCalibration.IMAGE_HEIGHT;
%[nr nc] = size(image); % Equivalent

K = getK();
R = eye(3);

[mx my] = meshgrid(1:nc, 1:nr);
px = reshape(mx', nc * nr, 1);
py = reshape(my', nc * nr, 1);

rays = inv(K) * [(px - 1)' ; (py - 1)' ; ones(1,length(px))];

% Rotation
rays2 = R' * rays;
x = [rays2(1,:)./rays2(3,:);rays2(2,:)./rays2(3,:)];

% Add distortion
xd = applyDistortion(x, k);

% Reconvert in pixels
px2 = f(1) * xd(1,:) + c(1);
py2 = f(2) * xd(2,:) + c(2);

% Interpolate between the closest pixels:
px_0 = floor(px2);
py_0 = floor(py2);

good_points = find((px_0 >= 0) & ...
                   (px_0 <= (nc-2)) & ...
                   (py_0 >= 0) & ...
                   (py_0 <= (nr-2)));

px2 = px2(good_points);
py2 = py2(good_points);
px_0 = px_0(good_points);
py_0 = py_0(good_points);

alpha_x = px2 - px_0;
alpha_y = py2 - py_0;

a1 = (1 - alpha_y).*(1 - alpha_x);
a2 = (1 - alpha_y).*alpha_x;
a3 = alpha_y .* (1 - alpha_x);
a4 = alpha_y .* alpha_x;

ind_lu = px_0 * nr + py_0 + 1;
ind_ru = (px_0 + 1) * nr + py_0 + 1;
ind_ld = px_0 * nr + (py_0 + 1) + 1;
ind_rd = (px_0 + 1) * nr + (py_0 + 1) + 1;

ind_new = (px(good_points)-1)*nr + py(good_points);

rectifiedImage = 255 * ones(size(image));
rectifiedImage(ind_new) = a1 .* image(ind_lu) + ...
                          a2 .* image(ind_ru) + ...
                          a3 .* image(ind_ld) + ...
                          a4 .* image(ind_rd);
% Cast output to uint8
rectifiedImage = uint8(rectifiedImage);
end

%--------------------------------------------------------------------------

function xd = applyDistortion(x, k)

assert(numel(k) == 5);

% Add distortion
r2 = x(1,:).^2 + x(2,:).^2;
r4 = r2.^2;
r6 = r2.^3;

% Radial distortion
cdist = 1 + k(1) * r2 + k(2) * r4 + k(5) * r6;
xd1 = x .* (ones(2,1) * cdist);

% Tangential distortion
a1 = 2 .* x(1,:) .* x(2,:);
a2 = r2 + 2 * x(1,:).^2;
a3 = r2 + 2 * x(2,:).^2;

delta_x = [k(3) * a1 + k(4) * a2 ;
           k(3) * a3 + k(4) * a1];

xd = xd1 + delta_x;

end
