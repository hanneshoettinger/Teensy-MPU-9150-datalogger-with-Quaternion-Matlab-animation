function Mpadded = padMatrixEdges(M, p)
%PADMATRIXEDGES Pad matrix edges with zeros.
%   M = PADMATRIXEDGES(M, P) pads the edges of matrix M with bands of zeros
%   of width P.

%   Author: Damien Teney

Mpadded = zeros(size(M) + p * 2); % Empty initialization

% Copy the middle
Mpadded(p + 1:p + size(M, 1), p + 1:p + size(M, 2)) = M;
