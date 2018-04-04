function M = loadCSV(fileName)
%LOADCSV Load 2D matrix from CSV file.
%   M = LOADCSV(FILENAME) loads a text file containing a 2D matrix, stored
%   in CSV format, using the semicolon to separate values.

%   Author: Damien Teney

if ~exist(fileName, 'file')
  error('File not found !');
end

M = dlmread(fileName, ';');
