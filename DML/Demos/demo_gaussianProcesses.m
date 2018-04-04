function demo_gaussianProcesses()
%DEMO_GAUSSIANPROCESSES Demo of regression using Gaussian processes.

%--------------------------------------------------------------------------
% Get data
%--------------------------------------------------------------------------
sprintf('Pick 20 points training points');
figure(); axis([-10 10 -10 10]); hold all;
points = pickPoints(10);

% Get vectors
trainingInput = points(:, 1); % Nx1
trainingOutput = points(:, 2); % Nx1
testInput = (-10:.1:10)'; % Mx1

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
f = [testOutput + 2 * sqrt(testOutputVariance); ...
     flipdim(testOutput - 2 * sqrt(testOutputVariance), 1)];
fill([testInput; flipdim(testInput, 1)], ...
     f, ...
     [.8 .8 .8]);
plot(trainingInput, trainingOutput, '+');
plot(testInput, testOutput, 'k-');

%==========================================================================

function [points] = pickPoints(n)
%PICKPOINTS(N) Let the user pick N points in the current figure

points = [];
for i = 1:n
  [xi yi] = ginput(1);
  plot(xi, yi, 'b.');
  points(i, :) = [xi yi];
end
