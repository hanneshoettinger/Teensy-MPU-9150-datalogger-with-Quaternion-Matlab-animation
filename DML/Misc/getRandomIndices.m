function randomIndices = getRandomIndices(N, minIndex, maxIndex)
%GETRANDOMINDICES Random indices without repetition.
%   RANDOMINDICES = GETRANDOMINDICES(N, MININDEX, MAXINDEX) returns N
%   random unique indices (ie, without repetition) between MININDEX and
%   MAXINDEX (bounds included).

%   Author: Damien Teney

% Generate all possible indices in random order
range = maxIndex + 1 - minIndex;
allIndices = randperm(range);
allIndices = allIndices + (minIndex - 1);

if N > range
  error('The number of indices asked is too big.');
end

% Select N of them
randomIndices = allIndices(1:N);
