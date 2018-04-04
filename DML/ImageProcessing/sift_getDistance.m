function d = sift_getDistance(descriptor1, descriptor2)
%SIFT_GETDISTANCE Euclidean distance between SIFT descriptors.
%   D = SIFT_GETDISTANCE(DESCRIPTOR1, DESCRIPTOR2) computes the Euclidean
%   distance between two SIFT descriptors (1x128 vectors).

%   Author: Damien Teney

d = norm(descriptor2(1, 1:128) - descriptor1(1, 1:128));
