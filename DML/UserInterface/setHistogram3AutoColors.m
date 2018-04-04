function setHistogram3AutoColors()
%SETHISTOGRAM3AUTOCOLORS Set automatic colors for a HIST3() figure.

%   Author: Damien Teney

set(gcf, 'renderer', 'opengl');
set(get(gca, 'child'), 'FaceColor', 'interp', 'CDataMode', 'auto');
colormap(summer);
