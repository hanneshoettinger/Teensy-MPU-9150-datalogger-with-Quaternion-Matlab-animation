function norms = getNormOfRows(M)
%GETNORMOFROWS Norm of each row of a matrix.
%   NORMS = GETNORMOFROWS(M) computes the 2-norm of each each row of a
%   matrix M.

%   Author: Damien Teney

norms = sqrt(sum(M.^2, 2)); % Norm of each row
