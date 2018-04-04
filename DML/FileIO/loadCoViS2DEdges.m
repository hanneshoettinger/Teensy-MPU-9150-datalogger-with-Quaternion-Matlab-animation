function data = loadCoViS2DEdges(fileName)
%LOADCOVIS2DEDGES Load CoViS 2D edge primitives.
%   DATA = LOADCOVIS2DEDGES(fileName) loads a text file describing CoViS
%   2D edge primitives, such as the ones produced by the 'slam' program.
%
%   DATA is of size Nx9:
%     1-2: position
%     3: orientation
%     4-6: left color (RGB)
%     7-9: right color (RGB)
%
%   See also:
%   http://www.covig.org

%   Author: Damien Teney

% Read the file
rawData = dlmread(fileName);

% Get general info
global CAMERA_CALIBRATION;
CAMERA_CALIBRATION{1}.IMAGE_WIDTH = rawData(2, 1);
CAMERA_CALIBRATION{1}.IMAGE_HEIGHT = rawData(2, 2);
nPrimitives = rawData(1, 1);

% Get the actual data
data = zeros(nPrimitives, 9);
data(:, 1) = rawData(3:end, 2); % X-position in image
data(:, 2) = rawData(3:end, 3); % Y-position in image
data(:, 3) = rawData(3:end, 16); % Orientation ([-pi,pi])
  data(:, 3) = data(:, 3) + pi/2;
data(:, 4:6) = rawData(3:end, 21:23); % Left color
data(:, 7:9) = rawData(3:end, 29:31); % Right color
