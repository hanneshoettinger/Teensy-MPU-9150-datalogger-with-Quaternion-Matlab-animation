function corners = extractCorners(image)
%EXTRACTCORNERS Coner detection in image.
%   CORNERS = EXTRACTCORNERS(IMAGE) detects corners in a given image (black
%   and white MxN, or color MxNx3), and returns a Px2 matrix containing the
%   indices of the P corners found.

%   Author: He Xiaochen
%   (http://www.mathworks.com/matlabcentral/fileexchange/7652), modified by
%   Damien Teney

%--------------------------------------------------------------------------
% Initialize parameters
%--------------------------------------------------------------------------
C = 1.5; % Minimum ratio of major axis to minor axis of an ellipse, whose vertex could be detected as a corner
T_angle = 162; % Maximum obtuse angle that a corner can have when detected as a true corner
sig = 3; % Standard deviation of the Gaussian filter when computeing curvature
H = 0.35; L = 0; % High and low thresholds of Canny edge detector
includeEndPoints = true; % Control whether to add curve end points as corners
maxGapSize = 1; % In pixels; max size of the gaps to be filled

if size(image,  3) == 3
  image = rgb2gray(image); % Transform RGB image to gray-level
end

%--------------------------------------------------------------------------
% Do the work
%--------------------------------------------------------------------------
edgeMap = edge(image, 'canny', [L H]); % Extract edges
[curve curve_start curve_end curve_mode curve_num] = extractCurves(edgeMap, maxGapSize); % Extract curves
%keyboard
cornersTmp = findCorners(curve, curve_start, curve_end, curve_mode, curve_num, sig, includeEndPoints, C, T_angle); % Detect corners
% Switch 1st and 2nd columns ((i,j) VS (x,y) indexing)
corners = cornersTmp;
corners(:, 1) = cornersTmp(:, 2);
corners(:, 2) = cornersTmp(:, 1);

%--------------------------------------------------------------------------
% Debug: visualization
%--------------------------------------------------------------------------
%{
figure(); imshow(image); hold all;
for i = 1:size(corners, 1) % For each detected corner
  plot(corners(i, 1), corners(i, 2), 'bo');
end
%}

%==========================================================================

function [curve curve_start curve_end curve_mode cur_num] = extractCurves(edgeMap, maxGapSize)
% Extract curves from binary edge map, if the endpoint of a contour is nearly connected to another endpoint,  fill the gap and continue the extraction.

[height width] = size(edgeMap);

% Empty initializations
curve       = [];
curve_start = [];
curve_end   = [];
curve_mode  = [];
cur_num     = 0;
edgeMap1 = zeros(height + 2 * maxGapSize, width + 2 * maxGapSize);
edgeMap_edge = zeros(height, width);
edgeMap1(maxGapSize + 1:maxGapSize + height, maxGapSize + 1:maxGapSize + width) = edgeMap;

[r c] = find(edgeMap1 == 1);

while size(r, 1) > 0
  point = [r(1), c(1)];
  cur = point;
  edgeMap1(point(1), point(2)) = 0;
  [I, J] = find(edgeMap1(point(1) - maxGapSize:point(1) + maxGapSize, point(2) - maxGapSize:point(2) + maxGapSize) == 1);
  while size(I, 1)>0
    dist = (I - maxGapSize - 1).^2 + (J - maxGapSize - 1).^2;
    [min_dist, index] = min(dist);
    point = point + [I(index), J(index)] - maxGapSize - 1;
    cur = [cur;point];
    edgeMap1(point(1), point(2)) = 0;
    [I, J] = find(edgeMap1(point(1) - maxGapSize:point(1) + maxGapSize, point(2) - maxGapSize:point(2) + maxGapSize) == 1);
  end

  % Extract edge towards another direction
  point = [r(1), c(1)];
  edgeMap1(point(1), point(2)) = 0;
  [I, J] = find(edgeMap1(point(1) - maxGapSize:point(1) + maxGapSize, point(2) - maxGapSize:point(2) + maxGapSize) == 1);
  while size(I, 1)>0
    dist = (I - maxGapSize - 1).^2 + (J - maxGapSize - 1).^2;
    [min_dist, index] = min(dist);
    point = point + [I(index), J(index)] - maxGapSize - 1;
    cur = [point;cur];
    edgeMap1(point(1), point(2)) = 0;
    [I, J] = find(edgeMap1(point(1) - maxGapSize:point(1) + maxGapSize, point(2) - maxGapSize:point(2) + maxGapSize) == 1);
  end

  if size(cur, 1)>(size(edgeMap, 1) + size(edgeMap, 2)) / 25
    cur_num = cur_num + 1;
    curve{cur_num} = cur - maxGapSize;
  end
  [r, c] = find(edgeMap1 == 1);

end

for i = 1:cur_num
  curve_start(i, :) = curve{i}(1, :);
  curve_end(i, :) = curve{i}(size(curve{i}, 1), :);
  if (curve_start(i, 1) - curve_end(i, 1))^2 + ...
    (curve_start(i, 2) - curve_end(i, 2))^2 <= 32
    curve_mode(i, :) = 'loop';
  else
    curve_mode(i, :) = 'line';
  end

  edgeMap_edge(curve{i}(:, 1) + (curve{i}(:, 2) - 1) * height) = 1;
end

% Debug: visualization
%imshow(~edgeMap_edge);

%==========================================================================

function corners = findCorners(curve, curve_start, curve_end, curve_mode, curve_num, sig, includeEndPoints, C, T_angle)

corner_num = 0;
corners = zeros(0, 2);

GaussianDieOff = .0001; 
pw = 1:30; 
ssq = sig * sig;
width = max(find(exp( - (pw .* pw) / (2 * ssq)) > GaussianDieOff));
if isempty(width)
  width = 1;  
end
t = ( - width:width);
gau = exp( - (t .* t) / (2 * ssq)) / (2 * pi * ssq); 
gau = gau / sum(gau);

for i = 1:curve_num;
  x = curve{i}(:, 1);
  y = curve{i}(:, 2);
  W = width;
  L = size(x, 1);
  if L > W
    %----------------------------------------------------------------------
    % Calculate curvature
    %----------------------------------------------------------------------
    if curve_mode(i, :) == 'loop'
      x1 = [x(L - W + 1:L);x;x(1:W)];
      y1 = [y(L - W + 1:L);y;y(1:W)];
    else
      x1 = [ones(W, 1) * 2 * x(1) - x(W + 1: - 1:2);x;ones(W, 1) * 2 * x(L) - x(L - 1: - 1:L - W)];
      y1 = [ones(W, 1) * 2 * y(1) - y(W + 1: - 1:2);y;ones(W, 1) * 2 * y(L) - y(L - 1: - 1:L - W)];
    end

    xx = conv(x1, gau);
    xx = xx(W + 1:L + 3 * W);
    yy = conv(y1, gau);
    yy = yy(W + 1:L + 3 * W);
    Xu = [xx(2) - xx(1) ; (xx(3:L + 2 * W) - xx(1:L + 2 * W - 2)) / 2 ; xx(L + 2 * W) - xx(L + 2 * W - 1)];
    Yu = [yy(2) - yy(1) ; (yy(3:L + 2 * W) - yy(1:L + 2 * W - 2)) / 2 ; yy(L + 2 * W) - yy(L + 2 * W - 1)];
    Xuu = [Xu(2) - Xu(1) ; (Xu(3:L + 2 * W) - Xu(1:L + 2 * W - 2)) / 2 ; Xu(L + 2 * W) - Xu(L + 2 * W - 1)];
    Yuu = [Yu(2) - Yu(1) ; (Yu(3:L + 2 * W) - Yu(1:L + 2 * W - 2)) / 2 ; Yu(L + 2 * W) - Yu(L + 2 * W - 1)];
    K = abs((Xu .* Yuu - Xuu.* Yu) ./ ((Xu.* Xu + Yu.* Yu).^1.5));
    K = ceil(K * 100) / 100;

    %----------------------------------------------------------------------
    % Find curvature local maxima as corner candidates
    %----------------------------------------------------------------------
    extremum = [];
    N = size(K, 1);
    n = 0;
    Search = 1;

    for j = 1:N - 1
      if (K(j + 1) - K(j)) * Search>0
        n = n + 1;
        extremum(n) = j;  % In extremum,  odd points is minima and even points is maxima
        Search = - Search;
      end
    end
    if mod(size(extremum, 2), 2) == 0
      n = n + 1;
      extremum(n) = N;
    end

    n = size(extremum, 2);
    flag = ones(size(extremum));

    %----------------------------------------------------------------------
    % Compare with adaptive local threshold to remove round corners
    %----------------------------------------------------------------------
    for j = 2:2:n
      %I = find(K(extremum(j - 1):extremum(j + 1)) == max(K(extremum(j - 1):extremum(j + 1))));
      %extremum(j) = extremum(j - 1) + round(mean(I)) - 1; % Regard middle point of plateaus as maxima

      [x, index1] = min(K(extremum(j): - 1:extremum(j - 1)));
      [x, index2] = min(K(extremum(j):extremum(j + 1)));
      ROS = K(extremum(j) - index1 + 1:extremum(j) + index2 - 1);
      K_thre(j) = C * mean(ROS);
      if K(extremum(j))<K_thre(j)
        flag(j) = 0;
      end
    end
    extremum = extremum(2:2:n);
    flag = flag(2:2:n);
    extremum = extremum(find(flag == 1));

    %----------------------------------------------------------------------
    % Check corner angle to remove false corners due to boundary noise and trivial details
    %----------------------------------------------------------------------
    flag = 0;
    smoothed_curve = [xx, yy];
    while sum(flag == 0)>0
      n = size(extremum, 2);
      flag = ones(size(extremum)); 
      for j = 1:n
        if j == 1 & j == n
          ang = curve_tangent(smoothed_curve(1:L + 2 * W, :), extremum(j));
        elseif j == 1 
          ang = curve_tangent(smoothed_curve(1:extremum(j + 1), :), extremum(j));
        elseif j == n
          ang = curve_tangent(smoothed_curve(extremum(j - 1):L + 2 * W, :), extremum(j) - extremum(j - 1) + 1);
        else
          ang = curve_tangent(smoothed_curve(extremum(j - 1):extremum(j + 1), :), extremum(j) - extremum(j - 1) + 1);
        end   
        if ang>T_angle & ang<(360 - T_angle)
          flag(j) = 0;  
        end
      end

      if size(extremum, 2) == 0
        extremum = [];
      else
        extremum = extremum(flag ~= 0);
      end
    end

    extremum = extremum - W;
    extremum = extremum(extremum>0 & extremum <= L);
    n = size(extremum, 2);   
    for j = 1:n   
      corner_num = corner_num + 1;
      corners(corner_num, :) = curve{i}(extremum(j), :);
    end
  end
end

%--------------------------------------------------------------------------
% Add end points
%--------------------------------------------------------------------------
if includeEndPoints
  for i = 1:curve_num
    if size(curve{i}, 1)>0 & curve_mode(i, :) == 'line'
      % Start point compare with detected corners
      compare_corner = corners - ones(size(corners, 1), 1) * curve_start(i, :);
      compare_corner = compare_corner.^2;
      compare_corner = compare_corner(:, 1) + compare_corner(:, 2);
      if min(compare_corner)>25     % Add end points far from detected corners 
        corner_num = corner_num + 1;
        corners(corner_num, :) = curve_start(i, :);
      end

      % End point compare with detected corners
      compare_corner = corners - ones(size(corners, 1), 1) * curve_end(i, :);
      compare_corner = compare_corner.^2;
      compare_corner = compare_corner(:, 1) + compare_corner(:, 2);
      if min(compare_corner)>25
        corner_num = corner_num + 1;
        corners(corner_num, :) = curve_end(i, :);
      end
    end
  end
end

%==========================================================================

function ang = curve_tangent(cur, center)

for i = 1:2
  if i == 1
    curve = cur(center: - 1:1, :);
  else
    curve = cur(center:size(cur, 1), :);
  end
  L = size(curve, 1);

  if L > 3
    if sum(curve(1, :) ~= curve(L, :)) ~= 0
      M = ceil(L / 2);
      x1 = curve(1, 1);
      y1 = curve(1, 2);
      x2 = curve(M, 1);
      y2 = curve(M, 2);
      x3 = curve(L, 1);
      y3 = curve(L, 2);
    else
      M1 = ceil(L / 3);
      M2 = ceil(2 * L / 3);
      x1 = curve(1, 1);
      y1 = curve(1, 2);
      x2 = curve(M1, 1);
      y2 = curve(M1, 2);
      x3 = curve(M2, 1);
      y3 = curve(M2, 2);
    end

    if abs((x1 - x2) * (y1 - y3) - (x1 - x3) * (y1 - y2)) < 1e-8  % Straight line
      tangent_direction = angle(complex(curve(L, 1) - curve(1, 1), curve(L, 2) - curve(1, 2)));
    else
      % Fit a circle 
      x0 = 1 / 2 * ( - y1 * x2^2 + y3 * x2^2 - y3 * y1^2 - y3 * x1^2 - y2 * y3^2 + x3^2 * y1 + y2 * y1^2 - y2 * x3^2 - y2^2 * y1 + y2 * x1^2 + y3^2 * y1 + y2^2 * y3) / ( - y1 * x2 + y1 * x3 + y3 * x2 + x1 * y2 - x1 * y3 - x3 * y2);
      y0 = - 1 / 2 * (x1^2 * x2 - x1^2 * x3 + y1^2 * x2 - y1^2 * x3 + x1 * x3^2 - x1 * x2^2 - x3^2 * x2 - y3^2 * x2 + x3 * y2^2 + x1 * y3^2 - x1 * y2^2 + x3 * x2^2) / ( - y1 * x2 + y1 * x3 + y3 * x2 + x1 * y2 - x1 * y3 - x3 * y2);
      % R = (x0 - x1)^2 + (y0 - y1)^2;

      radius_direction = angle(complex(x0 - x1, y0 - y1));
      adjacent_direction = angle(complex(x2 - x1, y2 - y1));
      tangent_direction = sign(sin(adjacent_direction - radius_direction)) * pi / 2 + radius_direction;
    end

  else
    % Very short line
    tangent_direction = angle(complex(curve(L, 1) - curve(1, 1), curve(L, 2) - curve(1, 2)));
  end
  direction(i) = tangent_direction * 180 / pi;
end

ang = abs(direction(1) - direction(2));
