function demo_colorNames
%DEMO_COLORNAMES Demo of color naming.

inputImage = double(imread('demo_colorNames.jpg'));
labeledImage = getColorNameFromRGB(inputImage);
coloredImage = getRGBFromColorName(labeledImage);

figure(); imshow(uint8(inputImage));
figure(); imshow(labeledImage, [1 11]);
figure(); imshow(coloredImage);
