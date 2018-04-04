function x = approximateInverseFunction(f, c, rangeMin, rangeMax, nIterations)
%APPROXIMATEINVERSEFUNCTION Approximation of the inverse of a function.
%   X = APPROXIMATEINVERSEFUNCTION(F, C) computes an approximation of X
%   in F(X) = C. f is supposed to be monotonic (increasing or decreasing).

%   Author: Damien Teney

% Check whether the function increasing or decreasing
if f(rangeMin) < f(rangeMax)
  increasingFunction = true;
else
  increasingFunction = false;
end

% Check whether the solution is indeed in the given range
if  increasingFunction && (c < f(rangeMin) || c > f(rangeMax)) ...
|| ~increasingFunction && (c > f(rangeMin) || c < f(rangeMax)) ...
  error('Solution not in the given range !');
end

searchHistory = zeros(nIterations, 4);

% Choose a starting point
currentRangeMin = min(rangeMin, rangeMax);
currentRangeMax = max(rangeMin, rangeMax);
currentRangeMid = (currentRangeMin + currentRangeMax) / 2;
currentRangeMidValue = f(currentRangeMid);

% Save the first step in the history of the search
searchHistory(1, 1) = currentRangeMin;
searchHistory(1, 2) = currentRangeMax;
searchHistory(1, 3) = currentRangeMid;
searchHistory(1, 4) = currentRangeMidValue;

for i = 2:nIterations
  % Update the current point
  if ( increasingFunction && currentRangeMidValue < c) ...
  || (~increasingFunction && currentRangeMidValue > c)
    currentRangeMin = currentRangeMid;
  else
    currentRangeMax = currentRangeMid;
  end
  currentRangeMid = (currentRangeMin + currentRangeMax) / 2;
  currentRangeMidValue = f(currentRangeMid);

  % Save an history of the search
  searchHistory(i, 1) = currentRangeMin;
  searchHistory(i, 2) = currentRangeMax;
  searchHistory(i, 3) = currentRangeMid;
  searchHistory(i, 4) = currentRangeMidValue;
end

x = currentRangeMin + (currentRangeMax - currentRangeMin) / 2;

% Debug display
%{
% Search range values
figure(); hold all;
for i = 1:nIterations
  plot([i i], [searchHistory(i, 1) searchHistory(i, 2)], '.-b');
  plot(i, searchHistory(i, 3), 'ob');
end
% Function values
figure(); hold all;
plot(searchHistory(1:nIterations, 4), 'k.-');
plot(nIterations, c, 'ro');
%}
