function edgeMap = getEdgeMap(image, threshold, sigma)
%GETEDGEMAP Find edges in RGB image.
%   EDGEMAP = GETEDGEMAP(IMAGE, THRESHOLD, SIGMA) takes an RGB image as its
%   input, and returns its edge map (a binary image); uses the Canny
%   method.

%   Author: based on Matlab EDGE(), modified by Damien Teney to use color images

if ndims(image) < 3 || size(image, 3) ~= 3
  error('The input image must have 3 channels !');
end

% Transform to a double precision intensity image if necessary
if ~isa(image,'double') && ~isa(image,'single')
  image = im2single(image);
end

% Initialize the output edge map
edgeMap = false(size(image, 1), size(image, 2));

% Calculate gradients using a derivative of Gaussian filter
[dxR dyR] = smoothGradient(image(:, :, 1), sigma);
[dxG dyG] = smoothGradient(image(:, :, 2), sigma);
[dxB dyB] = smoothGradient(image(:, :, 3), sigma);
dx = (dxR + dxG + dxB);
dy = (dyR + dyG + dyB);
%figure(); imshow(dx, []); figure(); imshow(dy, []); % Debug display

gradientMagnitude = hypot(dx, dy); % Get the magnitude of the gradient
% Normalize for threshold selection
magmax = max(gradientMagnitude(:));
if magmax > 0
  gradientMagnitude = gradientMagnitude / magmax;
end

% Perform Non-Maximum Suppression Thining and Hysteresis Thresholding of Edge
% Strength
lowThreshold  = 0.4 * threshold;
highThreshold =       threshold;
edgeMap = thinAndThreshold(edgeMap, dx, dy, gradientMagnitude, lowThreshold, highThreshold);

%==========================================================================

function idxLocalMax = cannyFindLocalMaxima(direction,ix,iy,mag)
%CANNYFINDLOCALMAXIMA
%
% This sub-function helps with the non-maximum suppression in the Canny
% edge detector.  The input parameters are:
%
%   direction - the index of which direction the gradient is pointing,
%               read from the diagram below. direction is 1, 2, 3, or 4.
%   ix        - input image filtered by derivative of gaussian along x
%   iy        - input image filtered by derivative of gaussian along y
%   mag       - the gradient magnitude image
%
%    there are 4 cases:
%
%                         The X marks the pixel in question, and each
%         3     2         of the quadrants for the gradient vector
%       O----0----0       fall into two cases, divided by the 45
%     4 |         | 1     degree line.  In one case the gradient
%       |         |       vector is more horizontal, and in the other
%       O    X    O       it is more vertical.  There are eight
%       |         |       divisions, but for the non-maximum suppression
%    (1)|         |(4)    we are only worried about 4 of them since we
%       O----O----O       use symmetric points about the center pixel.
%        (2)   (3)


[m,n] = size(mag);

% Find the indices of all points whose gradient (specified by the
% vector (ix,iy)) is going in the direction we're looking at.

switch direction
    case 1
        idx = find((iy<=0 & ix>-iy)  | (iy>=0 & ix<-iy));
    case 2
        idx = find((ix>0 & -iy>=ix)  | (ix<0 & -iy<=ix));
    case 3
        idx = find((ix<=0 & ix>iy) | (ix>=0 & ix<iy));
    case 4
        idx = find((iy<0 & ix<=iy) | (iy>0 & ix>=iy));
end

% Exclude the exterior pixels
if ~isempty(idx)
    v = mod(idx,m);
    extIdx = (v==1 | v==0 | idx<=m | (idx>(n-1)*m));
    idx(extIdx) = [];
end

ixv = ix(idx);
iyv = iy(idx);
gradmag = mag(idx);

% Do the linear interpolations for the interior pixels
switch direction
    case 1
        d = abs(iyv./ixv);
        gradmag1 = mag(idx+m).*(1-d) + mag(idx+m-1).*d;
        gradmag2 = mag(idx-m).*(1-d) + mag(idx-m+1).*d;
    case 2
        d = abs(ixv./iyv);
        gradmag1 = mag(idx-1).*(1-d) + mag(idx+m-1).*d;
        gradmag2 = mag(idx+1).*(1-d) + mag(idx-m+1).*d;
    case 3
        d = abs(ixv./iyv);
        gradmag1 = mag(idx-1).*(1-d) + mag(idx-m-1).*d;
        gradmag2 = mag(idx+1).*(1-d) + mag(idx+m+1).*d;
    case 4
        d = abs(iyv./ixv);
        gradmag1 = mag(idx-m).*(1-d) + mag(idx-m-1).*d;
        gradmag2 = mag(idx+m).*(1-d) + mag(idx+m+1).*d;
end
idxLocalMax = idx(gradmag>=gradmag1 & gradmag>=gradmag2);

%==========================================================================

function [GX, GY] = smoothGradient(I, sigma)
%SMOOTHGRADIENT

% Create an even-length 1-D separable Derivative of Gaussian filter

% Determine filter length
filterLength = 8*ceil(sigma);
n = (filterLength - 1)/2;
x = -n:n;

% Create 1-D Gaussian Kernel
c = 1/(sqrt(2*pi)*sigma);
gaussKernel = c * exp(-(x.^2)/(2*sigma^2));

% Normalize to ensure kernel sums to one
gaussKernel = gaussKernel/sum(gaussKernel);

% Create 1-D Derivative of Gaussian Kernel
derivGaussKernel = gradient(gaussKernel);

% Normalize to ensure kernel sums to zero
negVals = derivGaussKernel < 0;
posVals = derivGaussKernel > 0;
derivGaussKernel(posVals) = derivGaussKernel(posVals)/sum(derivGaussKernel(posVals));
derivGaussKernel(negVals) = derivGaussKernel(negVals)/abs(sum(derivGaussKernel(negVals)));

% Compute smoothed numerical gradient of image I along x (horizontal)
% direction. GX corresponds to dG/dx, where G is the Gaussian Smoothed
% version of image I.
GX = imfilter(I, gaussKernel', 'conv', 'replicate');
GX = imfilter(GX, derivGaussKernel, 'conv', 'replicate');

% Compute smoothed numerical gradient of image I along y (vertical)
% direction. GY corresponds to dG/dy, where G is the Gaussian Smoothed
% version of image I.
GY = imfilter(I, gaussKernel, 'conv', 'replicate');
GY  = imfilter(GY, derivGaussKernel', 'conv', 'replicate');

%==========================================================================

function H = thinAndThreshold(E, dx, dy, gradientMagnitude, lowThreshold, highThreshold)
%THINANDTHRESHOLD

% Perform Non-Maximum Suppression Thining and Hysteresis Thresholding of Edge
% Strength
    
% We will accrue indices which specify ON pixels in strong edgemap
% The array e will become the weak edge map.
idxStrong = [];
for dir = 1:4
    idxLocalMax = cannyFindLocalMaxima(dir,dx,dy,gradientMagnitude);
    idxWeak = idxLocalMax(gradientMagnitude(idxLocalMax) > lowThreshold);
    E(idxWeak)=1;
    idxStrong = [idxStrong; idxWeak(gradientMagnitude(idxWeak) > highThreshold)]; %#ok<AGROW>
end

[m,n] = size(E);

if ~isempty(idxStrong) % result is all zeros if idxStrong is empty
    rstrong = rem(idxStrong-1, m)+1;
    cstrong = floor((idxStrong-1)/m)+1;
    H = bwselect(E, cstrong, rstrong, 8);
else
    H = zeros(m, n);
end
