function maximaMap = getMatrixLocalMaxima(data, includeDiagonalElements, strictMaxima)
%GETMATRIXLOCALMAXIMA Non maximum suppression.
%   MAXIMAMAP = GETMATRIXLOCALMAXIMA(DATA, INCLUDEDIAGONALELEMENTS, STRICTMAXIMA)
%   returns a matrix of the same size as DATA, where an element is set to 1
%   if the corresponding element in DATA is surrounded by smaller values.
%
%   Depending on the second argument, 4 or 8 neighbours are considered.
%   Depending on the third argument, the surrounding value can be equal.

%   Author: Damien Teney

[m n] = size(data);

if nargin < 2
  includeDiagonalElements = false; % Default value
end

if nargin < 3
  strictMaxima = true; % Default value
end

% In 'maxNeighbouringValues', store, for each element, the maximum value of the corresponding neighbours (in 'data') centered around it

% Initialize
maxNeighbouringValues = data; maxNeighbouringValues(:) = min(data(:)); % Initialize with a small value, making sure it's of the same data type as 'data'

% Horizontally
dataShifted = [data(:, 2:end) -inf(m,1)      ];
maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);
dataShifted = [-inf(m,1)      data(:,1:end-1)];
maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);

% Vertically
dataShifted = [data(2:end, :) ; -inf(1,n)       ];
maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);
dataShifted = [-inf(1,n)       ; data(1:end-1,:)];
maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);

if includeDiagonalElements
  dataShifted(1, :) = -inf;
  dataShifted(:, 1) = -inf;
  dataShifted(2:end, 2:end) = data(1:end-1, 1:end-1);
  maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);

  dataShifted(end, :) = -inf;
  dataShifted(:, end) = -inf;
  dataShifted(1:end-1, 1:end-1) = data(2:end, 2:end);
  maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);

  dataShifted(end, :) = -inf;
  dataShifted(:,   1) = -inf;
  dataShifted(1:end-1, 2:end) = data(2:end, 1:end-1);
  maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);

  dataShifted(1,   :) = -inf;
  dataShifted(:, end) = -inf;
  dataShifted(2:end, 1:end-1) = data(1:end-1, 2:end);
  maxNeighbouringValues = max(dataShifted, maxNeighbouringValues);
end

% maximaMap
if strictMaxima
  maximaMap = (data > maxNeighbouringValues); % Strict maxima
else
  maximaMap = (data == maxNeighbouringValues); % Maxima can be equal to their neighbours
end
