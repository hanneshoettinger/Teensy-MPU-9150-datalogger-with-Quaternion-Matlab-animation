function displayHorizontalBar2D(yValue)
%DISPLAYHORIZONTALBAR2D Horizontal bar in 2D plot.
%   DISPLAYVERTICALBAR2D(XVALUE) adds an horizontal bar at the given Y
%   value in the current figure.

%   Author: Damien Teney

xLimits = get(gca, 'xlim');

plot(xLimits', ...
     [yValue ; yValue], ...
     'k-', ...
     'Color', [.75 .75 .75]);
