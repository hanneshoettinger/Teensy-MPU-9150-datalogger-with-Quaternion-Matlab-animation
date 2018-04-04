function a = replicateVector(a, n)
%REPLICATEVECTOR Replicate elements of a 1D vector.
%   A = REPLICATEVECTOR(A, N) replicates the vector A (1xM) N times
%   consecutively. The result is a (1x(M*N)) vector.
%
%   Note that similar effect can be obtain with REPMAT(); but this function
%   offers a simpler interface comparable to EXPANDVECTOR().

%   Author: Damien Teney

a = repmat(a, 1, n);
