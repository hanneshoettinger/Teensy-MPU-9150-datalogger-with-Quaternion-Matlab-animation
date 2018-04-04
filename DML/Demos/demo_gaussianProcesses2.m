function demo_gaussianProcesses2()
%DEMO_GAUSSIANPROCESSES Demo of regression using Gaussian processes with 2D/1D input/output.

%--------------------------------------------------------------------------
% Get data
%--------------------------------------------------------------------------
fullSurface = peaks(30);
% Put all the points in a list (Nx3 matrix)
fullSurfacePoints = zeros(size(fullSurface, 1) * size(fullSurface, 2), 3);
k = 1; % Index in fullSurfacePoints
for i = 1:size(fullSurface, 1)
  for j = 1:size(fullSurface, 2)
    fullSurfacePoints(k, 1:3) = [i j fullSurface(i, j)];
    k = k + 1;
  end
end
% Select a few points
partialSurfacePoints = fullSurfacePoints(getRandomIndices(100, 1, size(fullSurfacePoints, 1)), 1:3);
% Debug display
%figure(); plot3(fullSurfacePoints(:, 1), fullSurfacePoints(:, 2), fullSurfacePoints(:, 3), 'b.');
figure(); plot3(partialSurfacePoints(:, 1), partialSurfacePoints(:, 2), partialSurfacePoints(:, 3), 'b.');

% Get vectors
trainingInput = partialSurfacePoints(:, 1:2); % Nx2
trainingOutput = partialSurfacePoints(:, 3); % Nx1
testInput = fullSurfacePoints(getRandomIndices(100, 1, size(fullSurfacePoints, 1)), 1:2); % Mx2

%--------------------------------------------------------------------------
% Initialize hyperparameters
%--------------------------------------------------------------------------
hyperparameters.covariance = [log(1.5); log(1.5)]; % Length scale and standard deviation
hyperparameters.likelihood = log(0.1); % Noise variance
hyperparameters.mean = [1];

%--------------------------------------------------------------------------
% Optimize the hyperparameters
%--------------------------------------------------------------------------
hyperparameters = gp_optimize(hyperparameters, ... % Variables to optimize
                              @gp_getLikelihood, ... % Function to minimize
                              -100, ... % Max 100 function evaluations
                              trainingInput, trainingOutput);

% Display optimized hyperparameters
%hyperparameters
hyperparameters.covariance
hyperparameters.likelihood
hyperparameters.mean

%--------------------------------------------------------------------------
% Do the predictions
%--------------------------------------------------------------------------
[testOutput testOutputVariance] = gp_makePrediction(hyperparameters, trainingInput, trainingOutput, testInput); % Make prediction on test data

%--------------------------------------------------------------------------
% Display the results
%--------------------------------------------------------------------------
figure();
hold all;
plot3(testInput(:, 1), ...
      testInput(:, 2), ...
      testOutput(:, 1), ...
      'r+');
