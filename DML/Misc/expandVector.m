function a = expandVector(a, n)
%EXPANDVECTOR Replicate elements of a 1D vector.
%   A = EXPANDVECTOR(A, N) expands the vector A (1xM), so that each of its
%   elements appears N consecutive times. The result is a (1x(M*N)) vector.

%   Author: Damien Teney

indices = zeros(1, length(a) * n);
indices(1:n:length(a) * n) = 1;
indices = cumsum(indices);

a = a(indices);
