function demo_undistort
%DEMO_UNDISTORT Demo of the undistortion of an image.

CAMERA_CALIBRATION{1}.FOCAL_LENGTHS = [664.097358989632310 665.146419381329340];
CAMERA_CALIBRATION{1}.IMAGE_CENTER = [325.269689084823430 240.276418779415650];
CAMERA_CALIBRATION{1}.DISTORTION_COEFICIENTS = [-0.063057635824433 ...
                                      -0.018694051206822 ...
                                      -0.001331104187954 ...
                                       0.003567751579657 ...
                                       0.000000000000000];

image = imread('demoUndistort.png');
image2 = undistortImage_color(image, CAMERA_CALIBRATION{1});

figure, imshow(image);
figure, imshow(image2);
