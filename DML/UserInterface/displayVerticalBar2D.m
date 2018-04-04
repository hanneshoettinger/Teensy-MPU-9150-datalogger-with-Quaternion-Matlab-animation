function displayVerticalBar2D(xValue)
%DISPLAYVERTICALBAR2D Vertical bar in 2D plot.
%   DISPLAYVERTICALBAR2D(XVALUE) adds a vertical bar at the given X value in
%   the current figure.

%   Author: Damien Teney

yLimits = get(gca, 'ylim');

plot([xValue ; xValue], ...
     yLimits', ...
     'k-', ...
     'Color', [.75 .75 .75]);
