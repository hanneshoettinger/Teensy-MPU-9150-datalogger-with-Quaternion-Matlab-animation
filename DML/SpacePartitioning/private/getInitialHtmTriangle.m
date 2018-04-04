function [corner0 corner1 corner2] = getInitialHtmTriangle(index)
%GETINITIALHTMTRIANGLE Triangle corners from level-0 index (0-based !).
%   [CORNER0 CORNER1 CORNER2] = GETINITIALHTMTRIANGLE(INDEX)

%   Author: excerpt from the HTM (http://www.skyserver.org/htm), modified
%   by Damien Teney

% Define static constant data
faces = zeros(8, 3); % Indices of corners(warning: 0-based indices, NOT Matlab/1-based)
faces(1, 1:3) = [1 5 2]; % S0
faces(2, 1:3) = [2 5 3]; % S1
faces(3, 1:3) = [3 5 4]; % S2
faces(4, 1:3) = [4 5 1]; % S3
faces(5, 1:3) = [1 0 4]; % N0
faces(6, 1:3) = [4 0 3]; % N1
faces(7, 1:3) = [3 0 2]; % N2
faces(8, 1:3) = [2 0 1]; % N3
points = zeros(6, 3);
points(1, 1:3) = [ 0.0  0.0  1.0];
points(2, 1:3) = [ 1.0  0.0  0.0];
points(3, 1:3) = [ 0.0  1.0  0.0];
points(4, 1:3) = [-1.0  0.0  0.0];
points(5, 1:3) = [ 0.0 -1.0  0.0];
points(6, 1:3) = [ 0.0  0.0 -1.0];

% Debug display
%{
figure(); hold on;
plot3(points(:, 1), points(:, 2), points(:, 3), 'k.');
plot3(points(1, 1), points(1, 2), points(1, 3), 'ro');
%}

% Get the triangle corners
face = faces(index + 1, :); % Warning: 'index' is 0-based
corner0 = points(face(1) + 1, 1:3); % Warning: the elements of 'face' are 0-based indices
corner1 = points(face(2) + 1, 1:3);
corner2 = points(face(3) + 1, 1:3);
