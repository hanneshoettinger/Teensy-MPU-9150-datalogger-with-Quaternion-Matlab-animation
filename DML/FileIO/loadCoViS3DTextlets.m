function primitives = loadCoViS3DTextlets(fileName)
%LOADCOVIS3DTEXTLETS Load CoViS 3D textlet primitives.
%   DATA = LOADCOVIS3DTEXTLETS(fileName) loads an XML file describing CoViS
%   3D edge primitives, such as the ones produced by the 'slam' program.
%
%   DATA is of size Nx31:
%     1-3: position (X, Y, Z)
%     4-6: orientation (3-vector)
%     7-15: position covariance (3x3 matrix)
%     16-24: orientation covariance (3x3 matrix)
%     25-27: color (RGB)
%     28-30: empty
%     31: part ID (integer)
%
%   See also:
%   http://www.covig.org

%   Author: Damien Teney

%--------------------------------------------------------------------------
% Open the file
%--------------------------------------------------------------------------
% Read the file
document = xmlread(fileName);
root = document.getDocumentElement();

% Check the version of the file
fileVersion = root.getAttribute('version');
assert(strcmp(fileVersion, '1.0'));

%--------------------------------------------------------------------------
% Parse the file
%--------------------------------------------------------------------------
% Parse child nodes
items = root.getElementsByTagName('Primitive3D');
nItems = items.getLength();

% Initialize output
currentPrimitive = zeros(1, 31);
primitives = zeros(nItems, 31);

% For each node
for i = 0:(nItems - 1)
  primitive = items.item(i);

  %------------------------------------------------------------------------
  % Get part ID
  %------------------------------------------------------------------------
  partID = primitive.getAttribute('partID');
  if length(partID) < 1
    partID = 0; % Default value
  else
    partID = round(str2double(partID));
  end
  currentPrimitive(31) = partID;

  %------------------------------------------------------------------------
  % Get location
  %------------------------------------------------------------------------
  primitive_location = primitive.getElementsByTagName('Location').item(0);
    primitive_location_cartesian3D = primitive_location.getElementsByTagName('Cartesian3D').item(0);
      % Location value
      currentPrimitive(1) = str2double(primitive_location_cartesian3D.getAttribute('x'));
      currentPrimitive(2) = str2double(primitive_location_cartesian3D.getAttribute('y'));
      currentPrimitive(3) = str2double(primitive_location_cartesian3D.getAttribute('z'));

    primitive_location_cartesian3DCovariance = primitive_location.getElementsByTagName('Cartesian3DCovariance').item(0);
      % Location covariance
      locationCovariance = str2num(primitive_location_cartesian3DCovariance.getFirstChild.getData());
      locationCovariance = reshape(locationCovariance, 3, 3);
      currentPrimitive(7:15) = locationCovariance(:);

  %------------------------------------------------------------------------
  % Get orientation
  %------------------------------------------------------------------------
  primitive_orientation = primitive.getElementsByTagName('Orientation').item(0);

    primitive_orientation_cartesian3D = primitive_orientation.getElementsByTagName('Cartesian3D').item(0);
      % Orientation value
      currentPrimitive(4) = str2double(primitive_orientation_cartesian3D.getAttribute('x'));
      currentPrimitive(5) = str2double(primitive_orientation_cartesian3D.getAttribute('y'));
      currentPrimitive(6) = str2double(primitive_orientation_cartesian3D.getAttribute('z'));

    primitive_orientation_cartesian3DCovariance = primitive_orientation.getElementsByTagName('Orientation3DCovariance').item(0);
      % Orientation covariance
      orientationCovariance = str2num(primitive_orientation_cartesian3DCovariance.getFirstChild.getData());
      orientationCovariance = reshape(orientationCovariance, 3, 3);
      currentPrimitive(16:24) = orientationCovariance(:);

  %------------------------------------------------------------------------
  % Get appearance/color
  %------------------------------------------------------------------------
  primitive_colors = primitive.getElementsByTagName('Color').item(0);
      primitive_colors_rgb = primitive_colors.getElementsByTagName('RGB').item(0);
        % Color value
        r = str2double(primitive_colors_rgb.getAttribute('r'));
        g = str2double(primitive_colors_rgb.getAttribute('g'));
        b = str2double(primitive_colors_rgb.getAttribute('b'));
        currentPrimitive(25:27) = [r g b];
        currentPrimitive(28:30) = [0 0 0];

  primitives((i + 1), :) = currentPrimitive;
end
