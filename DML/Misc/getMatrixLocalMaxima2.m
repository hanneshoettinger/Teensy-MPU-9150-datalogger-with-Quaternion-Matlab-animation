function maximaMap = getMatrixLocalMaxima2(data, minValue, neighbourhoodRadius)
%GETMATRIXLOCALMAXIMA2 Non maximum suppression.
%   MAXIMA = GETMATRIXLOCALMAXIMA2(DATA, MINVALUE, NEIGHBOURHOODRADIUS)
%   returns a map locating the local maxima of value > MINVALUE in DATA.
%   Two maxima are separated by a distance at least equal to NEIGHBOURHOODRADIUS.

%   Author: Damien Teney

assert(ndims(data) == 2);

% Make a list of all candidates for being local maxima
[tmpI tmpJ tmpValues] = find(data);
maximaCandidates = [tmpI tmpJ tmpValues];
maximaCandidates = sortrows(maximaCandidates, -3); % Sort them by descending value
maximaCandidates = maximaCandidates(maximaCandidates(:, 3) > minValue, :); % Keep only the ones above the given value
nCandidates = size(maximaCandidates, 1);

connectedComponents = bwlabel(data > minValue, 8); % Get a map of connected components

% Initialize
maximaMap = zeros(size(data));
exclusionMap = zeros(size(data));

for i = 1:nCandidates
  currentCandidate = maximaCandidates(i, 1:3); % Rename for clarity

  if exclusionMap(currentCandidate(1), currentCandidate(2)) > 0 % Current candidate already exclude
    continue; % Skip it
  end

  % Mark it in the map of maxima
  maximaMap(currentCandidate(1), currentCandidate(2)) = 1;

  % Mark an exclusion zone around it
  mask1 = zeros(size(data)); mask1(currentCandidate(1), currentCandidate(2)) = 1; mask1 = imdilate(mask1, strel('disk', neighbourhoodRadius, 0));
  mask2 = (connectedComponents == connectedComponents(currentCandidate(1), currentCandidate(2)));
  exclusionMap = exclusionMap | (mask1 & mask2);
  % Debug display
  %{
  figure(); imshow(mask1);
  figure(); imshow(mask2);
  figure(); imshow(mask1 & mask2);
  figure(); imshow(exclusionMap);
  %}
  %figure(); imshow(maximaMap); pause();
end
