function maximizeFigure(figureId)
%MAXIMIZEFIGURE Maximize figure to fill the entire screen.
%   MAXIMIZEFIGURE(FIGUREID) maximizes the figure, the identifier of which
%   is given, so that it fills the entire screen.

%   Author: Damien Teney

if nargin == 0
  figureId = gcf; % Default value
end

% Method 1
%{
units = get(figureId, 'units');
set(figureId, 'units', 'normalized', 'outerposition', [0 0 1 1]);
set(figureId, 'units', units);
%}

% Method 2
set(figureId, 'Position', get(0, 'Screensize'));
