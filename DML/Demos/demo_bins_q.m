function demo_bins_q
%DEMO_BINS_Q Demo of the partitioning of the 3-sphere (unit quaternions).

resolution = 3;
nBins = q_getBinCount(resolution)

displayFunction = @displayPoses;
%displayFunction = @displayPoses2;

%--------------------------------------------------------------------------
% Shows points and the bins they fall into
%--------------------------------------------------------------------------
displayFunction([], true, 'b.'); % Empty figure
for i = 1:4
  % Get a random point and display it
  q = q_getRandom();
  displayFunction([0 0 0 q], false, 'b.')

  % Get its ID
  binIndex = q_getBinIndex(q, resolution);
  binCenter = q_getBinCenter(binIndex, resolution);

  % Display the border of the bin
  [corner00 corner01 corner02 corner10 corner11 corner12] = q_getBinLimits(binIndex, resolution);
  displayFunction([0 0 0 corner00 ;
                   0 0 0 corner01 ;
                   0 0 0 corner02 ;
                   0 0 0 corner00], false, 'k-');
  displayFunction([0 0 0 corner10 ;
                   0 0 0 corner11 ;
                   0 0 0 corner12 ;
                   0 0 0 corner10], false, 'k-');
  displayFunction([0 0 0 corner00 ;
                   0 0 0 corner10], false, 'k-');
  displayFunction([0 0 0 corner01 ;
                   0 0 0 corner11], false, 'k-');
  displayFunction([0 0 0 corner02 ;
                   0 0 0 corner12], false, 'k-');

  % Display the center of the bin
  binCenter = q_getBinCenter(binIndex, resolution);
  displayFunction([0 0 0 q ; 0 0 0 binCenter], false, 'k-');
  displayFunction([0 0 0 binCenter], false, 'r.')
end

%--------------------------------------------------------------------------
% Display one bin, with many points that fall in that bin
%--------------------------------------------------------------------------
% Choose a bin
binIndex = getRandomInteger_uniform(0, q_getBinCount(resolution));
binCenter = q_getBinCenter(binIndex, resolution);

% Display the center of the bin
displayFunction([0 0 0 binCenter], true, 'ro');
% Display the border of the bin
[corner00 corner01 corner02 corner10 corner11 corner12] = q_getBinLimits(binIndex, resolution);
displayFunction([0 0 0 corner00 ;
                 0 0 0 corner01 ;
                 0 0 0 corner02 ;
                 0 0 0 corner00], false, 'k-');
displayFunction([0 0 0 corner10 ;
                 0 0 0 corner11 ;
                 0 0 0 corner12 ;
                 0 0 0 corner10], false, 'k-');
displayFunction([0 0 0 corner00 ;
                 0 0 0 corner10], false, 'k-');
displayFunction([0 0 0 corner01 ;
                 0 0 0 corner11], false, 'k-');
displayFunction([0 0 0 corner02 ;
                 0 0 0 corner12], false, 'k-');

for i = 1:1000 % For each point to test
  q = q_getRandom_VMF(binCenter, 64);
  binIndex2 = q_getBinIndex(q, resolution);
  if binIndex2 == binIndex % Fall in the same bin
    displayFunction([0 0 0 q], false, 'b.');
  else % Fall in another bin
    %displayFunction([0 0 0 q], false, 'k.');
  end
end
pause();

%--------------------------------------------------------------------------
% Display all bins
%--------------------------------------------------------------------------
%%{
displayFunction([], true, 'b.'); % Empty figure
for binIndex = 0:2:(q_getBinCount(resolution) - 1)
  binCenter = q_getBinCenter(binIndex, resolution);

  % Display the border of the bin
  [corner00 corner01 corner02 corner10 corner11 corner12] = q_getBinLimits(binIndex, resolution);
  displayFunction([0 0 0 corner00 ;
                   0 0 0 corner01 ;
                     0 0 0 corner02 ;
                 0 0 0 corner00], false, 'k-');
  displayFunction([0 0 0 corner10 ;
                   0 0 0 corner11 ;
                   0 0 0 corner12 ;
                   0 0 0 corner10], false, 'k-');
  displayFunction([0 0 0 corner00 ;
                   0 0 0 corner10], false, 'k-');
  displayFunction([0 0 0 corner01 ;
                   0 0 0 corner11], false, 'k-');
  displayFunction([0 0 0 corner02 ;
                   0 0 0 corner12], false, 'k-');

  %displayFunction([0 0 0 binCenter], false, 'r.')
  drawnow();
  %pause;
end
%}

%--------------------------------------------------------------------------
% Show that the bin indices are linearly distributed
%--------------------------------------------------------------------------
nIterations = 5000;
indices = zeros(1, nIterations);
for i = 1:nIterations
  q = q_getRandom();
  indices(i) = q_getBinIndex(q, resolution);
end

% Show that the indices are linearly distributed
figure(); hist(double(indices), nIterations / 100);

%--------------------------------------------------------------------------
% Generate evenly distributed points
%--------------------------------------------------------------------------
resolution = 0;
displayFunction = @displayPoses;

points = q_getUniformGrid(resolution);
nPoints = size(points, 1)

% Display the points
displayFunction([], true, 'b.')
for i = 1:nPoints
  displayFunction([0 0 0 points(i, 1:4)], false, 'b.');
end
