function demo_projectPointOnLine()
%DEMO_PROJECTPOINTONLINE Demo of the projection of a 3D point on a line.

displayEmpty3DFigure();
axis square;
grid on;

% Define the line and display it
a = [-1 -5 -7];
b = [10 15 2];
plot3([a(1) b(1)], ...
      [a(2) b(2)], ...
      [a(3) b(3)], 'k-.');

% Define the point and display it
p = [5 9 2];
plot3(p(1), p(2), p(3), 'b.');

% Get the projection and display it
p2 = projectPointOnLine(p, a, b);
plot3([p(1) p2(1)], ...
      [p(2) p2(2)], ...
      [p(3) p2(3)], 'g');

% Verification
dot(p2 - p, b - a) % Should be 0 (orthogonal vectors)

% Compute the distance between the point and the line
% Both methods should give the same result
d1 = norm(p2 - p)
d2 = getPointLineDistance(p, a, b)
