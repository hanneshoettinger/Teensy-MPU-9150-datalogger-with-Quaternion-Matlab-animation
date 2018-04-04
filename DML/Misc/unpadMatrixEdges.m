function M = unpadMatrixEdges(Mpadded, p)
%UNPADMATRIXEDGES Remove matrix edges.
%   M = UNPADMATRIXEDGES(M, P) removes a border of width P around the
%   matrix M.

%   Author: Damien Teney

M = Mpadded(p + 1:end - p, p + 1:end - p);
