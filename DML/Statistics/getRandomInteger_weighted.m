function returnedValues = getRandomInteger_weighted(weights, N)
%GETRANDOMINTEGER_WEIGHTED  Weighted random integers.
%   X = GETRANDOMINTEGER_WEIGHTED(WEIGHTS, N) takes a vector of M weights
%   (not necessarily summing to one), and returns a random value in [1,M]
%   with probabilities proportional to the given weights.
%
%   If N is given and > 1, several numbers are generated, and X is 1xN.

%   Author: Damien Teney

if nargin < 2
  N = 1; % Set default value
end

weights = weights(:)'; % Make sure we have a line vector
M = length(weights);

% Method 2 O(N + M)
% See:
% http://stackoverflow.com/questions/2140787/select-random-k-elements-from-a-list-whose-elements-have-weights/2149533#2149533
%{
returnedValues = zeros(1, N); outputIndex = 1;

total = sum(weights);
i = 0;
w = weights(1); v = 1;
while N > 0
  x = total * (1 - rand() ^ (1.0 / N))
  total = total - x;
  while x > w
    x = x - w;
    i = i + 1;
    w = weights(i); v = i;
  end
  w = w - x;
  returnedValues(outputIndex) = v; outputIndex = outputIndex + 1;

  N = N - 1;
end
%}

% Method 1
%%{
% Get random numbers in [0,1]
randomNumbers = rand(N, length(weights));

% Correct the probabilities for the weights
probabilities = zeros(N, M);
for i = 1:N
  probabilities(i, :) = randomNumbers(i, :) .^ (1 ./ weights);
end

% Keep the most probable one
[~, x] = max(probabilities, [], 2);

returnedValues = x;
%}
