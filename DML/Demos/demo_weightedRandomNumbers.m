function demo_weightedRandomNumbers()
%DEMO_WEIGHTEDRANDOMNUMBERS Demo of sampling of weighted random numbers.

weights = [.5 .3 .2]

% Get many samples
for i = 1:10000
  picks(i) = getRandomInteger_weighted(weights);
end

% Check that the probabilities of occurrence (should correspond to the given weights)
occurrences(1) = length(find(picks == 1)) / length(picks);
occurrences(2) = length(find(picks == 2)) / length(picks);
occurrences(3) = length(find(picks == 3)) / length(picks);
occurrences
