function displayVerticalBar3D(xValue, yValue)
%DISPLAYVERTICALBAR3D Vertical bar in 3D plot.
%   DISPLAYVERTICALBAR3D(XVALUE) adds a vertical bar at the given (X, Y)
%   value in the current figure.

%   Author: Damien Teney

zLimits = get(gca, 'zlim');

plot3([xValue ; xValue], ...
      [yValue ; yValue], ...
      zLimits', ...
      'k-', ...
      'Color', [.75 .75 .75]);
