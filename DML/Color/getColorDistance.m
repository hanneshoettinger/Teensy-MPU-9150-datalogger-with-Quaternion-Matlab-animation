function d = getColorDistance(color1, color2)
%GETCOLORDISTANCE Distance measure between two RGB colors.
%   D = GETCOLORDISTANCE(COLOR1, COLOR2) returns a distance measure between
%   two RGB colors (1x3 vectors).
%
%   Also works with several colors at a time (Nx3 matrices).

%   Author: Damien Teney

d = getNormOfRows(color2(:, 1:3) - color1(:, 1:3));
