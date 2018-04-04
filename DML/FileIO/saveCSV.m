function saveCSV(M, fileName, enableExtraPrecision)
%SAVECSV Save 2D matrix to CSV file.
%   SAVECSV(M, FILENAME, ENABLEEXTRAPRECISION) saves a 2D matrix M to a CSV
%   file, using the semicolon to separate values.

%   Author: Damien Teney

if nargin > 2 && enableExtraPrecision
  dlmwrite(fileName, M, 'delimiter', ';', 'precision', '%e'); % Scientific (exponent) style numbers
else
  dlmwrite(fileName, M, 'delimiter', ';'); % Default precision
end
