function sift_match(imageFileName1, imageFileName2)
%SIFT_MATCH Demo of matching of SIFT features.
%   SIFT_MATCH(IMAGEFILENAME1, IMAGEFILENAME2)

%   Author: D. Lowe, modified by Damien Teney

% Find SIFT keypoints for each image
[descriptors1 locations1] = sift_extractFeatures(imageFileName1);
[descriptors2 locations2] = sift_extractFeatures(imageFileName2);

% Note: for efficiency in Matlab, it is cheaper to compute dot products
% between unit vectors rather than Euclidean distances. The ratio of angles
% (acos of dot products of unit vectors) is a close approximation to the
% ratio of Euclidean distances for small angles.

ratioThreshold = 0.6; % Will keep matches in which the ratio of vector angles from the nearest to second nearest neighbor is less than this
descriptors2t = descriptors2'; % Precompute matrix transpose
for i = 1 : size(descriptors1,1) % For each descriptor in the first image
  % Select its match to second image
  [sortedDistances sortedIndices] = sort(acos(descriptors1(i, :) * descriptors2t));  % Inverse cosine of dot products

  % Check if nearest neighbor has angle less than distRatio times 2nd.
  if (sortedDistances(1) < ratioThreshold * sortedDistances(2))
    match(i) = sortedIndices(1);
    distances(i) = sift_getDistance(descriptors1(i, :), descriptors2(sortedIndices(1), :)); % For debug/info
  else
    match(i) = 0;
  end
end

% Display the result (lines joining the accepted matches)
image1 = imread(imageFileName1);
image2 = imread(imageFileName2);
image3 = appendimages(image1, image2); % Create a new image showing the two images side by side
figure(); imshow(image3); hold on;

image1Width = size(image1, 2);
for i = 1: size(descriptors1,1)
  if (match(i) > 0)
   line([locations1(i,1) locations2(match(i), 1) + image1Width], ...
        [locations1(i,2) locations2(match(i), 2)        ], 'Color', 'c');
  end
end
nMatches = sum(match > 0);

fprintf('Matches found: %d\n', nMatches);
fprintf('Max distance: %.2f\n', max(distances));

%==========================================================================
function im = appendimages(image1, image2)
%APPENDIMAGES Append images side-by-side

% Select the image with the fewest rows and fill in enough empty rows to make it the same height as the other image
rows1 = size(image1,1);
rows2 = size(image2,1);

if (rows1 < rows2)
  image1(rows2, 1) = 0;
else
  image2(rows1, 1) = 0;
end

im = [image1 image2];   
