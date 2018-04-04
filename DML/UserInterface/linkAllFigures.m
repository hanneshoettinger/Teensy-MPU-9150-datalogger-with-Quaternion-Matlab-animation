function linkAllFigures()
%LINKALLFIGURES Link properties of all open figures.
%   LINKALLFIGURES() links most visual properties of all current open
%   figures, so that a change (e.g. a zoom) in one of them will be
%   effective in all other at the same time.

%   Author: Damien Teney

% Get handles of all axes of current figures
handles = findobj('Type','axes');

% Link their properties
hlink = linkprop(handles, {'CameraPosition', 'CameraUpVector', 'CameraTarget', 'CameraViewAngle', 'Projection', 'XLim', 'YLim', 'ZLim', 'XTick', 'YTick', 'ZTick'});

% Store link object on first subplot axes (necessary to keep a link to the link, otherwise it is lost/discarded)
setappdata(handles(1), 'graphics_linkprop', hlink);
