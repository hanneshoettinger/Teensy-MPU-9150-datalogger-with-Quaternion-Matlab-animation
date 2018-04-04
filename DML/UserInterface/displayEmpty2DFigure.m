function figureId = displayEmpty2DFigure(caption, newFigure)
%DISPLAYEMPTY2DFIGURE Display an empty 2D figure.
%   FIGUREID = DISPLAYEMPTY2DFIGURE(CAPTION, NEWFIGURE) displays a new blank
%   2D figure, the size of which is loaded from the global variable
%   CAMERA_CALIBRATION. 'hold on' is executed so that subsequent plot
%   commands will draw in that figure.
%
%   An optional caption for the figure can be specified.
%
%   If NEWFIGURE is specified and equal to FALSE, does not create a new
%   figure but affects the current axes. FIGUREID then equals -1.

%   Author: Damien Teney

if ~(nargin >= 2) || newFigure % newFigure not specified, or == true
  figureId = figure();
else
  cla('reset');
  figureId = -1;
end

global CAMERA_CALIBRATION;
imshow(ones([CAMERA_CALIBRATION{1}.IMAGE_HEIGHT CAMERA_CALIBRATION{1}.IMAGE_WIDTH]));
hold on;

if nargin >= 1
  title(caption);
else
  title([]);
end
