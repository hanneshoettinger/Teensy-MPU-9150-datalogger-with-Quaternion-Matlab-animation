function mat2 = removeMatrixRows(mat, maxNRows)
%REMOVEMATRIXROWS Remove rowd randomly from a given matrix.
%   MAT2 = REMOVEMATRIXROWS(MAT, MAXNROWS) removes rows from the given
%   matrix mat, so that it contains only MAXNROWS rows, and return the
%   result. The order of the rows in the result is also randomized.

%   Author: Damien Teney

if (maxNRows >= size(mat, 1))
  mat2 = mat;
else
  rowIndices = randperm(size(mat, 1));
  rowsToKeepIndices = rowIndices(1:maxNRows);
  mat2 = mat(rowsToKeepIndices, :);
end
