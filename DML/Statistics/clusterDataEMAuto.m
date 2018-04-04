function [labels nClusters] = clusterDataEMAuto(data)
%CLUSTERDATAEMAUTO Clustering with automatic number of clusters.
%   [LABELS NPARTS] = CLUSTERDATAEMAUTO(DATA) clusters the data with
%   CLUSTERDATAEM(), using different numbers of clusters, and select the
%   most appropriagte result using the Bayesian information criterion.

%   Author: Damien Teney

C = .28; % Constant, manually defined; the larger it is, the more it will penalize large numbers of clusters
MAX_N_CLUSTERS = 4;
N_RUNS = 4; % Since the result of the clustering is non deterministic, we do a few runs a we'll keep the best one

nDataPoints = size(data, 1);

for nClusters = 1:MAX_N_CLUSTERS
  for run = 1:N_RUNS
    [computedLabels trash logLikelihood] = clusterDataEM(data, nClusters);

    % Discard clustering runs where clusters have very few points
    for cluster = 1:nClusters % For each cluster
      if length(find(computedLabels == cluster)) < (nDataPoints / nClusters) / 4
        logLikelihood = -inf; % Discard this run
      end
    end


    labels(nClusters, run, :) = computedLabels;
    logLikelihoods(nClusters, run) = logLikelihood;
  end
end

for nClusters = 1:MAX_N_CLUSTERS
  % Keep the best run for each number of clusters
  [logLikelihoodsBest(nClusters) bestRunIndex] = max(logLikelihoods(nClusters, :));
  labelsBest(nClusters, :) = labels(nClusters, bestRunIndex, :);

  % Compute the Bayesian information criterion
  bayesianInformationCriterions(nClusters) = ...
    -2 * logLikelihoodsBest(nClusters) + C * nClusters * log(nDataPoints);
end

figure(); bar(bayesianInformationCriterions);
% Find the number of clusters that minimizes the criterion
[trash bestNClusters] = min(bayesianInformationCriterions);

% Rename the result for returning it
nClusters = bestNClusters;
labels = labelsBest(bestNClusters, :);
