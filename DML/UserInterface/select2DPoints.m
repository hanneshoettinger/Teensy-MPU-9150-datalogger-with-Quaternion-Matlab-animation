function selectedPoints = select2DPoints(X, Y)
% SELECT3DPOINTS  Interactively select 2D points in the current figure.
%   SELECTEDPOINTS = SELECT2DPOINTS(X, Y) let the user draw a box in the
%   current figure, then returns logical array, of the same size as the
%   input matrices, containing 1 if a point is inside the box, 0
%   otherwise.
%
%   X and Y are vectors or matrices of points coordinates.

%   Author: Damien Teney

if size(X) ~= size(Y)
  error('Arguments must be of the same size.')
end

[M N] = size(X);

% Get rbbox points 
waitforbuttonpress();
point1 = get(gca, 'CurrentPoint'); % Button down detected
rbbox(); % Return figure units
point2 = get(gca, 'CurrentPoint'); % Button up detected

% Get rbbox limits
XXmin = min(point1(1, 1), point2(1, 1));
XXmax = max(point1(1, 1), point2(1, 1));
YYmin = min(point1(1, 2), point2(1, 2));
YYmax = max(point1(1, 2), point2(1, 2));

% Select the points
XX = X(:);
YY = Y(:);
selectedPoints = XX >= XXmin & ...
                 XX <= XXmax & ...
                 YY >= YYmin & ...
                 YY <= YYmax;
