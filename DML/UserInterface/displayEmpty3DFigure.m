function figureId = displayEmpty3DFigure(caption, newFigure)
%DISPLAYEMPTY3DFIGURE Display an empty 3D figure.
%   FIGUREID = DISPLAYEMPTY3DFIGURE(CAPTION, NEWFIGURE) displays a new
%   blank 3D figure; 'hold on' is executed so that subsequent plot3
%   commands will draw in that figure. An optional caption for the figure
%   can be specified.
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

axis equal; axis vis3d; hold on;

grid on; % Turn on the grid
view(3); % Set oblique viewpoint

if nargin >= 1
  title(caption);
else
  title([]);
end

maximizeFigure();
