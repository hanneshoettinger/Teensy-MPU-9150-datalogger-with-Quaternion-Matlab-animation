function [labels model logLikelihood] = clusterDataEM(data, k)
%CLUSTERDATAEM Clustering by expectation maximization algorithm.
%   [LABELS MODEL LOGLIKELIHOOD] = CLUSTERDATAEM(DATA, K) performs
%   maximum likelihood estimation of Gaussian mixture model by using
%   expectation maximization algorithm. Data can be of any dimension N,
%   and is provided in a MxN matrix. K is the number of clusters.
%
%   The labels are returned in a 1xM vector, the model is a structure of
%   3 elements: mu, sigma, weight.

%   Author: Mo Chen
%   (http://www.mathworks.com/matlabcentral/fileexchange/26184-em-algorithm-for-gaussian-mixture-model),
%   modified by Damien Teney

% Initialization
data = data'; % The rest of the code assumes NxM matrix
R = initialization(data, k);

tol = 1e-6;
maxiter = 500;
llh = -inf(1, maxiter);
converged = false;
t = 1;
while (~converged && t < maxiter) || (k == 1 && t == 2)
  t = t + 1;
  model = maximization(data, R);
  [R, llh(t)] = expectation(data, model);
  converged = llh(t) - llh(t - 1) < tol * abs(llh(t));
end
[~, labels(1, :)] = max(R, [], 2);
llh = llh(2:t);
if ~converged
  printf('Clustering did not converge in %d steps.\n', maxiter);
end
logLikelihood = llh(end); % Return the maximized log likelihood

function R = initialization(data, k)
  n = size(data, 2);

  if k == 1
    labels = ones(1, n);
  else
    % Random initialization
    idx = randsample(n, k);
    m = data(:, idx);
    [~, labels] = max(bsxfun(@minus, m' * data, sum(m.^2, 1)' / 2));
    while k ~= unique(labels)
      idx = randsample(n, k);
      m = data(:, idx);
      [~, labels] = max(bsxfun(@minus, m' * data, sum(m.^2, 1)' / 2));
    end
  end
  R = full(sparse(1:n, labels, 1, n, k, n));
end

function [R llh] = expectation(data, model)
  mu = model.mu;
  sigma = model.sigma;
  w = model.weight;

  n = size(data, 2);
  k = size(mu, 2);
  R = zeros(n, k);

  for i = 1:k
      R(:, i) = logGaussPdf(data, mu(:, i), sigma(:, :, i));
  end
  R = bsxfun(@plus, R, log(w));
  T = logSumExp(R, 2);
  llh = sum(T) / n; % Log likelihood
  R = bsxfun(@minus, R, T);
  R = exp(R);
end

function model = maximization(data, R)
  [d n] = size(data);
  k = size(R, 2);
  sigma0 = eye(d) * (1e-6); % Regularization factor for covariance

  s = sum(R, 1);
  w = s / n;
  mu = bsxfun(@rdivide, data * R, s);
  sigma = zeros(d, d, k);
  for i = 1:k
      Xo = bsxfun(@minus, data, mu(:, i));
      Xo = bsxfun(@times, Xo, sqrt(R(:, i)'));
      sigma(:, :, i) = (Xo * Xo' + sigma0) / s(i);
  end

  model.mu = mu;
  model.sigma = sigma;
  model.weight = w;
end

function y = logGaussPdf(data, mu, sigma)
  % Log pdf of Gaussian
  d = size(data, 1);
  [R p]= cholcov(sigma, 0);
  if p ~= 0
    error('Error: sigma not SPD.');
  end
  data = bsxfun(@minus, data, mu);
  c = d * log(2 * pi) + 2 * sum(log(diag(R)));
  q = sum((R' \ data).^2, 1);
  y = -(c + q) / 2;
end

function s = logSumExp(x, dim)
  % Returns log(sum(exp(x),dim)) while avoiding numerical underflow.
  % Default is dim = 1 (columns).
  % Written by Mo Chen (mochen@ie.cuhk.edu.hk). March 2009.
  if nargin == 1, 
    % Determine which dimension sum will use
    dim = find(size(x) ~= 1, 1);
    if isempty(dim)
      dim = 1;
    end
  end

  % Subtract the largest in each column
  y = max(x, [], dim);
  % dims = ones(1,ndims(x));
  % dims(dim) = size(x,dim);
  % x = x - repmat(y, dims);
  x = bsxfun(@minus, x, y);
  s = y + log(sum(exp(x), dim));
  i = find(~isfinite(y));
  if ~isempty(i)
      s(i) = y(i);
  end
end

end
