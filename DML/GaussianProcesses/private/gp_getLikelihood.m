function [likelihood likelihoodDerivatives] = gp_getLikelihood(hyperparameters, x, y)
%GP_GETLIKELIHOOD Gaussian likelihood for Gaussian processes.
%   [LIKELIHOOD LIKELIHOODDERIVATIVES] = GP_GETLIKELIHOOD(HYPERPARAMETERS,
%    X, Y) computes a parametrization of the posterior, the negative log
%    marginal likelihood and its derivatives w.r.t. the hyperparameters.

%   Author: C. E. Rasmussen, Hannes Nickisch, modified by Damien Teney

n = size(x, 1);

K = gp_computeCovariance(hyperparameters.covariance, x, x); % Evaluate covariance matrix

% Rename hyperparameter
s = exp(2 * hyperparameters.likelihood);

% Get posterior
[alpha sW L] = gp_getPosterior(hyperparameters, x, y);

% Get marginal likelihood
yMinusMean = y - repmat(hyperparameters.mean', size(y, 1), 1);
likelihood = 0;
for i = 1:size(y, 2) % For each dimension of the output
  likelihood = likelihood + ...
                yMinusMean(:, i)' * alpha(:, i) / 2 + sum(log(diag(L))) + n * log(2 * pi * s) / 2; % -log marg lik
end

% Get marginal likelihood derivatives
likelihoodDerivatives = hyperparameters; % Initialization

Q = gp_solveCholesky(L, eye(n)) / s - alpha * alpha'; % Precompute for convenience

% Derivative against the covariance hyperparameters
for i = 1:numel(hyperparameters.covariance)
  likelihoodDerivatives.covariance(i) = sum(sum(Q .* gp_computeCovariance(hyperparameters.covariance, x, x, i))) / 2;
end

% Derivative against the likelihood hyperparameters
likelihoodDerivatives.likelihood = s * trace(Q);

% Derivative against the mean hyperparameters
for i = 1:numel(hyperparameters.mean)
  likelihoodDerivatives.mean(i) = -ones(1, size(x, 1)) * alpha(:, i);
end
