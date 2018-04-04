function coloredImage = getRGBFromColorName(labeledImage)
%GETRGBFROMCOLORNAME RGB value from standard color name.
%   COLOREDIMAGE = GETRGBFROMCOLORNAME(LABELEDIMAGE) takes an image (MxN) labeled with standard color IDs (see reference below), and return an RGB image (MxNx3) with those colors.

%   Author: Joost van de Weijer, refactored by Damien Teney
%   http://lear.inrialpes.fr/people/vandeweijer/research

%                 black  ,  blue   , brown       , grey       , green   , orange   , pink     , purple  , red     , white    , yellow
colorValues = {  [0 0 0] , [0 0 1] , [.5 .4 .25] , [.5 .5 .5] , [0 1 0] , [1 .8 0] , [1 .5 1] , [1 0 1] , [1 0 0] , [1 1 1 ] , [ 1 1 0 ] };

% Get the image dimensions
height = size(labeledImage, 1);
width = size(labeledImage, 2);

coloredImage = zeros(size(labeledImage, 1), size(labeledImage, 2), 3);
coloredImage = uint8(coloredImage);

for i = 1:height
  for j = 1:width
    coloredImage(i, j, :) = colorValues{labeledImage(i, j)}';
  end
end
