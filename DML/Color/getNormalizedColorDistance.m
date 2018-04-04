function d = getNormalizedColorDistance(color1, color2)
%GETNORMALIZEDCOLORDISTANCE Luminosity-independant distance measure between two RGB colors.
%   D = GETNORMALIZEDCOLORDISTANCE(COLOR1, COLOR2) returns a distance 
%   measure between two RGB colors. The colors are normalized for
%   luminosity first.

%   Author: Damien Teney

% Normalize the colors
color1Normalized = color1 ./ sum(color1(1:3));
color2Normalized = color2 ./ sum(color2(1:3));

% Get the distance between the two
d = norm(color2Normalized(1:3) - color1Normalized(1:3));
