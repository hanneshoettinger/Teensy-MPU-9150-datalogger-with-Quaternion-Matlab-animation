function [alpha sW L] = gp_getPosterior(hyperparameters, x, y)
%GP_GETLIKELIHOOD Gaussian likelihood for Gaussian processes.
%   [ALPHA SW L] = GP_GETPOSTERIOR(HYPERPARAMETERS, X, Y) computes a
%   parametrization of the posterior.

%   Author: inspired by code of C. E. Rasmussen, H. Nickisch
%   (http://gaussianprocess.org/gpml/code), modified by Damien Teney

%mean = {@meanZero};
%mean = {@gp_meanSum, {@gp_meanLinear, @gp_meanConst}};
mean = {@gp_meanConst};

n = size(x, 1);

K = gp_computeCovariance(hyperparameters.covariance, x, x); % Evaluate covariance matrix

% Rename hyperparameter
s = exp(2 * hyperparameters.likelihood);

% Get posterior 
L = chol(K / s + eye(n)); % Cholesky factor of covariance with noise, L = chol(eye(n) + sW * sW' .* K)
yMinusMean = y - repmat(hyperparameters.mean', size(y, 1), 1);
alpha = gp_solveCholesky(L, yMinusMean) / s;
sW = ones(n, 1) / sqrt(s); % sqrt of noise precision vector
