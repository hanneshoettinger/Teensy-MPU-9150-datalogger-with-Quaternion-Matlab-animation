function demo_clustering
%DEMO_CLUSTERING Demo of clustering.

% Load data
load demo_clustering;

% Perform clustering
[labels model]= clusterDataEM(data, 3);
mu = model.mu
sigma = model.sigma
weight = model.weight

% Show the result
figure, hold on;
for i = 1:size(data, 1) % For each data point
  color = strcat(getColor(labels(i)), '.');
  plot(data(i, 1), data(i, 2), ...
    'Color', color);
end
