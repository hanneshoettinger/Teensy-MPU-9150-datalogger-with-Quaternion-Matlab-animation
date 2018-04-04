function selectedPoints = select3DPoints(X, Y, Z)
%SELECT3DPOINTS Interactively select 3D points in the current figure.
%   SELECTEDPOINTS = SELECT3DPOINTS(X, Y, Z) let the user draw a box in
%   the current figure, then returns logical array, of the same size as
%   the input matrices, containing 1 if a point is inside the box, 0
%   otherwise.
%
%   X, Y and Z are vectors or matrices of points coordinates.

%   Author: Yuri Kotliarov
%   (http://www.mathworks.com/matlabcentral/fileexchange/7191-rbb3select),
%   modified by Damien Teney

if size(X) ~= size(Y) | size(X) ~= size(Z)
  error('Arguments must be of the same size.')
end

[M N] = size(X);

% Get the projection matrix for current view
%P = view();
P = get(gca, 'x_RenderTransform');

% Get rbbox points 
waitforbuttonpress();
point1 = get(gca, 'CurrentPoint'); % Button down detected
rbbox(); % Return figure units
point2 = get(gca, 'CurrentPoint'); % Button up detected

% Get upper points and convert to screen projection
P1 = P * [point1(1, :) 1]';
P2 = P * [point2(1, :) 1]';

% Get rbbox limits
XXmin = min(P1(1), P2(1));
XXmax = max(P1(1), P2(1));
YYmin = min(P1(2), P2(2));
YYmax = max(P1(2), P2(2));

% Convert X, Y, Z to screen projection
XYZ = P * [X(:) Y(:) Z(:) ones(M*N, 1)]';
% get new coordinates
XX = reshape(XYZ(1, :), M, N);
YY = reshape(XYZ(2, :), M, N);

% Select the points
selectedPoints = XX >= XXmin & ...
                 XX <= XXmax & ...
                 YY >= YYmin & ...
                 YY <= YYmax;
