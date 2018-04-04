function labeledImage = getColorNameFromRGB(rgbImage)
%GETCOLORNAMEFROMRGB Standard color name from RGB value/image.
%   LABELEDIMAGE = GETCOLORNAMEFROMRGB(RGBIMAGE) takes a RGB value (1x3) or an RGB image (MxNx3), and classify the colors into "standard" colors (see reference below). LABELEDIMAGE is a MxN matrix of color IDs (in [1, 11]).

%   Author: Joost van de Weijer, refactored by Damien Teney
%   http://lear.inrialpes.fr/people/vandeweijer/research

% Check input argument
if isa(rgbImage, 'integer')
  rgbImage = double(rgbImage);
end
if isa(rgbImage, 'double')
  rgbImage = double(rgbImage * 255);
end
% Now 'rgbImage' is made of doubles in [0, 255]
if ndims(rgbImage) == 2 % Single RGB color given as argument (1x3 or 3x1 vector)
  rgbImage = rgbImage(:);
  rgbImage = shiftdim(rgbImage, -2); % Transform to a 1x1 image (1x1x3 matrix)
end

% Get the image dimensions
height = size(rgbImage, 1);
width = size(rgbImage, 2);

RR = rgbImage(:, :, 1);
GG = rgbImage(:, :, 2);
BB = rgbImage(:, :, 3);

rgbIndices = 1 + floor(RR(:)/8) + 32*floor(GG(:)/8) + 32 * 32 * floor(BB(:) / 8);

load('colorNames.mat');
[max1 w2cM] = max(w2c, [], 2);
labeledImage = reshape(w2cM(rgbIndices(:)), height, width);
