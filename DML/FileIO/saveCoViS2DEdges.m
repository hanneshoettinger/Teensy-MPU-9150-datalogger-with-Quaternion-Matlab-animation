function saveCoViS2DEdges(data, fileName)
%SAVECOVIS2DEDGES Save CoViS 2D edge primitives.
%   SAVECOVIS2DEDGES(DATA, FILENAME) saves a text file in the CoViS format
%   with the given 2D edge primitives (such as files produced by the 'slam'
%   program).
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

outputFile = fopen(fileName, 'w');

global CAMERA_CALIBRATION;

% Write header
fprintf(outputFile, '%d\n', size(data, 1)); % Number of primitives
fprintf(outputFile, '%d  %d\n', CAMERA_CALIBRATION{1}.IMAGE_WIDTH, CAMERA_CALIBRATION{1}.IMAGE_HEIGHT); % Image size

% Write primitives
for i = 1:size(data, 1)
  writePrimitive(outputFile, data(i, :), i - 1);
end

fclose(outputFile);

%==========================================================================

function writePrimitive(outputFile, primitive, index)
%WRITEPRIMITIVE Write one primitive in the CoViS text format.

% Start the line with the index of the primitive in the file
fprintf(outputFile, '%d ', index);

lineToWrite = [
  primitive(1) % X
  primitive(2) % Y
  2 % Length
  1 % Confidence
  1 % Confidence for intrinsic dimensionality 0
  1 % Confidence for intrinsic dimensionality 1
  1 % Confidence for intrinsic dimensionality 2
  1 % Position uncertainty 0x0
  1 % Position uncertainty 0x1
  1 % Position uncertainty 1x0
  1 % Position uncertainty 1x1
  -100 % Unused field
  -100 % Unused field
  -100 % Unused field
  (primitive(3) - (pi / 2)) % Orientation in radians (in [-pi,pi])
  1 % Unused field
  1 % Orientation uncertainty
  0 % Phase
  -1 % Unused field
  primitive(4) % Left color r
  primitive(5) % Left color g
  primitive(6) % Left color b
  1 % Left color confidence
  1 % Middle color r
  1 % Middle color g
  1 % Middle color b
  1 % Middle color confidence
  primitive(7) % Right color r
  primitive(8) % Right color g
  primitive(9) % Right color b
  1 % Right color confidence
  -1000 % Unused field
  -1000 % Unused field
];

  fprintf(outputFile, '%f ', lineToWrite);
fprintf(outputFile, '\n'); % End of line
