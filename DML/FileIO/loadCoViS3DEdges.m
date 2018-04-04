function primitives = loadCoViS3DEdges(fileName)
%LOADCOVIS3DEDGES Load CoViS 3D edge primitives.
%   DATA = LOADCOVIS3DEDGES(fileName) loads an XML file describing CoViS 3D
%   edge primitives, such as the ones produced by the 'slam' program.
%
%   DATA is of size Nx31:
%     1-3: position (X, Y, Z)
%     4-6: orientation (3-vector)
%     7-15: position covariance (3x3 matrix)
%     16-24: orientation covariance (3x3 matrix)
%     25-27: left color (RGB)
%     28-30: right color (RGB)
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
    primitive_orientation_dirGammaOrientation =   primitive_orientation.getElementsByTagName('DirGammaOrientation').item(0);
      primitive_orientation_dirGammaOrientation_Direction = primitive_orientation_dirGammaOrientation.getElementsByTagName('Direction').item(0);
        primitive_orientation_dirGammaOrientation_Direction_Spherical = primitive_orientation_dirGammaOrientation_Direction.getElementsByTagName('Spherical').item(0);
          % Orientation value
          phi = str2double(primitive_orientation_dirGammaOrientation_Direction_Spherical.getAttribute('phi'));
          psi = str2double(primitive_orientation_dirGammaOrientation_Direction_Spherical.getAttribute('psi'));
          % Transform angles to a quaternion
          currentPrimitive(4:6) = v3_getFromEulerAngles(phi, psi);

    primitive_orientation_cartesian3DCovariance = primitive_orientation.getElementsByTagName('Cartesian3DCovariance').item(0);
      % Orientation covariance
      orientationCovariance = str2num(primitive_orientation_cartesian3DCovariance.getFirstChild.getData());
      orientationCovariance = reshape(orientationCovariance, 3, 3);
      currentPrimitive(16:24) = orientationCovariance(:);

  %------------------------------------------------------------------------
  % Get appearance/color
  %------------------------------------------------------------------------
  primitive_colors = primitive.getElementsByTagName('Colors').item(0);
    primitive_colors_left = primitive_colors.getElementsByTagName('Left').item(0);
      primitive_colors_left_rgb = primitive_colors_left.getElementsByTagName('RGB').item(0);
        % Left color value
        r = str2double(primitive_colors_left_rgb.getAttribute('r'));
        g = str2double(primitive_colors_left_rgb.getAttribute('g'));
        b = str2double(primitive_colors_left_rgb.getAttribute('b'));
        currentPrimitive(25:27) = [r g b];

    primitive_colors_right = primitive_colors.getElementsByTagName('Right').item(0);
      primitive_colors_right_rgb = primitive_colors_right.getElementsByTagName('RGB').item(0);
        % Right color value
        r = str2double(primitive_colors_right_rgb.getAttribute('r'));
        g = str2double(primitive_colors_right_rgb.getAttribute('g'));
        b = str2double(primitive_colors_right_rgb.getAttribute('b'));
        currentPrimitive(28:30) = [r g b];

  primitives((i + 1), :) = currentPrimitive;
end
