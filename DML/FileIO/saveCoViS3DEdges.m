function saveCoViS3DEdges(data, fileName)
%SAVECOVIS3DEDGES Save CoViS 3D edge primitives.
%   SAVECOVIS3DEDGES(DATA, FILENAME) saves an XML file in the CoViS format
%   with the given 3D edge primitives.
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

outputFile = fopen(fileName, 'w');

% Write header
fprintf(outputFile, '<?xml version="1.0" encoding="UTF-8" ?>\n');
fprintf(outputFile, '<Scene version="1.0">\n');

% Write primitives
for i = 1:size(data, 1)
  writePrimitive(outputFile, data(i, :));
end

% Write footer
fprintf(outputFile, '</Scene>\n');
fclose(outputFile);

%==========================================================================

function writePrimitive(outputFile, primitive)
%WRITEPRIMITIVE Write one primitive in the CoViS XML format.

position = primitive(1, 1:3);
orientation = primitive(1, 4:7);
[phi psi] = v3_getEulerAngles(orientation);
positionCovariance = primitive(1, 7:15);
orientationCovariance = primitive(1, 16:24);
leftColor = primitive(1, 25:27);
rightColor = primitive(1, 28:30);
partID = primitive(31);

fprintf(outputFile, '    <Primitive3D type="	 l" confidence="1" length="4" partID="%d">\n', partID);
fprintf(outputFile, '        <Location>\n');
fprintf(outputFile, '            <Cartesian3D x="%2.6f" y="%2.6f" z="%2.6f" />\n', position(1), position(2), position(3));
fprintf(outputFile, '            <Cartesian3DCovariance>');
for i = 1:9
  fprintf(outputFile, '%2.6f ', positionCovariance(i));
end
fprintf(outputFile, '</Cartesian3DCovariance>\n');
fprintf(outputFile, '        </Location>\n');
fprintf(outputFile, '        <Orientation>\n');
fprintf(outputFile, '            <DirGammaOrientation>\n');
fprintf(outputFile, '                <GammaVector>\n');
fprintf(outputFile, '                    <Cartesian3D x="1" y="0" z="0" />\n');
fprintf(outputFile, '                </GammaVector>\n');
fprintf(outputFile, '                <Direction>\n');
fprintf(outputFile, '                    <Spherical phi="%2.6f" psi="%2.6f" />\n', phi, psi);
fprintf(outputFile, '                    <Conf>-1</Conf>\n');
fprintf(outputFile, '                </Direction>\n');
fprintf(outputFile, '            </DirGammaOrientation>\n');
fprintf(outputFile, '            <Cartesian3DCovariance>');
for i = 1:9
  fprintf(outputFile, '%2.6f ', orientationCovariance(i));
end
fprintf(outputFile, '</Cartesian3DCovariance>\n');
fprintf(outputFile, '        </Orientation>\n');
fprintf(outputFile, '        <IntrinsicDimensionality>\n');
fprintf(outputFile, '            <Barycentric c0="0" c1="1" c2="0" />\n');
fprintf(outputFile, '        </IntrinsicDimensionality>\n');
fprintf(outputFile, '        <Source2D>\n');
fprintf(outputFile, '            <First>0</First>\n');
fprintf(outputFile, '            <Second>0</Second>\n');
fprintf(outputFile, '        </Source2D>\n');
fprintf(outputFile, '        <Phase>\n');
fprintf(outputFile, '            <Angle>0</Angle>\n');
fprintf(outputFile, '            <Conf>0</Conf>\n');
fprintf(outputFile, '        </Phase>\n');
fprintf(outputFile, '        <Colors>\n');
fprintf(outputFile, '            <Left>\n');
fprintf(outputFile, '                <RGB r="%2.6f" g="%2.6f" b="%2.6f" />\n', leftColor(1), leftColor(2), leftColor(3));
fprintf(outputFile, '                <Conf>1</Conf>\n');
fprintf(outputFile, '            </Left>\n');
fprintf(outputFile, '            <Right>\n');
fprintf(outputFile, '                <RGB r="%2.6f" g="%2.6f" b="%2.6f" />\n', rightColor(1), rightColor(2), rightColor(3));
fprintf(outputFile, '                <Conf>1</Conf>\n');
fprintf(outputFile, '            </Right>\n');
fprintf(outputFile, '            <Middle>\n');
fprintf(outputFile, '                <RGB r="0" g="0" b="0" />\n');
fprintf(outputFile, '                <Conf>1</Conf>\n');
fprintf(outputFile, '            </Middle>\n');
fprintf(outputFile, '        </Colors>\n');
fprintf(outputFile, '    </Primitive3D>\n');
