function [ymu ys2] = gp_makePrediction(hyperparameters, x, y, xs)
%GP_MAKEPREDICTION Gaussian process prediction (with zero mean).
%   [YMU YS2] = GP_MAKEPREDICTION(hyperparameters, x, y, xs) computes a
%   prediction from given test cases.
%
%   Inputs:
%     X   training inputs (n x D)
%     Y   training outputs (n x 1)
%     XS  test inputs (ns x D)
%
%   Outputs:
%     YMU predictive output means (nx x 1)
%     YS2 predictive output variances (ns x 1)

%   Author: inspired by code of C. E. Rasmussen, H. Nickisch
%   (http://gaussianprocess.org/gpml/code), modified by Damien Teney

% Initialize output variables
numberOfTestPoints = size(xs, 1);
ymu = zeros(numberOfTestPoints, size(y, 2));
ys2 = zeros(numberOfTestPoints, 1);

n = size(x, 1);
sigmaNoise = exp(hyperparameters.likelihood);

Ktraining = gp_computeCovariance(hyperparameters.covariance, x, x);

for i = 1:numberOfTestPoints % For each test point
  Ks  = gp_computeCovariance(hyperparameters.covariance, x, xs(i, :)); % Cross covariances
  kss = gp_computeCovariance(hyperparameters.covariance, xs(i, :), 'diag'); % Self variance

  % Get predictive mean
  yMinusMean = y - repmat(hyperparameters.mean', size(y, 1), 1);
  ymu(i, :) = hyperparameters.mean' + ...
              Ks' * pinv(Ktraining + eye(n) * sigmaNoise^2) * yMinusMean;

  % Get predictive variance
  ys2(i, :) = sigmaNoise^2 + ...
              kss - Ks' * pinv(Ktraining + eye(n) * sigmaNoise^2) * Ks;
end
