function [descriptors locations] = sift_extractFeatures(imageFileName)
%SIFT_EXTRACTFEATURES Extract SIFT features.
%   [DESCRIPTORS LOCATIONS] = SIFT_EXTRACTFEATURES(IMAGEFILENAME) extracts
%   SIFT features from a given image file.
%
%   DESCRIPTORS is a Kx128 matrix (rows of unit length).
%   LOCATIONS is a Kx4 matrix (X position, Y position, scale, orientation
%   in [0, 2 * pi[).

%   Author: D. Alvaro, J.J. Guerrero, modified by D. Lowe, remodified again
%   by Damien Teney

% Load image
image = imread(imageFileName);

% Convert the input image to a suitable format (grayscale PGM, readable by "keypoints" executable))
if size(image, 3) > 1 % RGB image
  image = rgb2gray(image); % Convert to grayscale
end
imwrite(image, 'tmp-sift.pgm');

% Call the SIFT executable
[path trash trash] = fileparts(mfilename('fullpath'));
if isunix
  command = [path filesep 'sift_linux <tmp-sift.pgm >tmp-sift.key'];
else
  command = [path filesep 'sift_win32 <tmp-sift.pgm >tmp-sift.key'];
end
[status result] = system(command); % Quietly run the external executable

% Open 'tmp-sift.key' and check its header
g = fopen('tmp-sift.key', 'r');
if g == -1
  error('Could not open file tmp-sift.key.');
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
  error('Invalid keypoint file beginning.');
end
num = header(1);
len = header(2);
if len ~= 128
  error('Keypoint descriptor length invalid (should be 128).');
end

% Creates output matrices
locations = double(zeros(num, 4));
descriptors = double(zeros(num, 128));

% Parse 'tmp-sift.key'
for i = 1:num
  [vector, count] = fscanf(g, '%f %f %f %f', [1 4]); % row col scale ori
  if count ~= 4
    error('Invalid keypoint file format');
  end
  locations(i, :) = vector(1, :);
  
  [descrip, count] = fscanf(g, '%d', [1 len]);
  if (count ~= 128)
    error('Invalid keypoint file value.');
  end

  % Normalize each input vector to unit length
  descrip = descrip / sqrt(sum(descrip.^2));
  descriptors(i, :) = descrip(1, :);
end
fclose(g);

locations(:, 1:4) = locations(:, [2 1 3 4]); % Switch from i/j indices to X/Y coordinates
locations(:, 4) = mod(locations(:, 4), 2 * pi); % Set orientation angles in [0, 2 * pi[

% Delete temporary files
delete('tmp-sift.pgm');
delete('tmp-sift.key');
