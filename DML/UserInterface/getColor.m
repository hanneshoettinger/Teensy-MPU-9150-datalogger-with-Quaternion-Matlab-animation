function color = getColor(index)
%GETCOLOR Random color.
%   COLOR = GETCOLOR(INDEX) returns a random color (1x3 vector; RGB).
%   If an index is given, several calls to the function with the same
%   index will return the same color.

%   Author: Damien Teney

% Declare persistent variable
persistent colorList % Nx3

if nargin < 1
  rand('twister', sum(100 * clock))
  index = round(rand * size(colorList, 1)) + 1;
end

if length(colorList) <= 0 % First call to the function
  % Set a list of colors
  colorList = [0.9 1.0 0.1;
               0.0 1.0 0.0;
               0.0 0.9 1.0;
               0.0 0.1 1.0;
               0.0 0.6 0.6;
               0.6 0.6 0.0;
               0.6 0.0 0.6;
               1.0 0.0 0.8];

  % Reorder randomly
  colorList = colorList(randperm(size(colorList, 1)), :);

  % Set the first color of the list
  colorList = [.4 .4 .4; ... % Gray
               colorList];
end

color = colorList(mod(index, length(colorList)) + 1, :);
