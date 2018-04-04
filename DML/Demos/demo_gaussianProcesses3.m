function demo_gaussianProcesses3()
%DEMO_GAUSSIANPROCESSES Demo of regression using Gaussian processes with 1D/2D input/output.

%--------------------------------------------------------------------------
% Get data
%--------------------------------------------------------------------------
% Training data
nTrainingPoints = 40;
trainingInput = zeros(nTrainingPoints, 1); % Nx1
for i = 1:nTrainingPoints
  trainingInput(i) = getRandom_uniform(0, 20);
end
trainingOutput(:, 1:2) = [cos(trainingInput) sin(trainingInput)]; % Nx2
N = size(trainingOutput, 1);
for i = 1:N
  trainingOutput(i, 1:2) = trainingOutput(i, 1:2) + mvnrnd([0 0], 0.05 * eye(2));
end

% Debug display
figure(); hold all;
plot3(trainingOutput(:, 1), trainingOutput(:, 2), trainingInput(:, 1), 'b.');

% Test data
testInput = (-10:.2:30)';

%--------------------------------------------------------------------------
% Initialize hyperparameters
%--------------------------------------------------------------------------
hyperparameters.covariance = [log(1.5); log(1.5)]; % Length scale and standard deviation
hyperparameters.likelihood = log(0.1); % Noise variance
hyperparameters.mean = [0; 0];

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
%figure(); hold all;
plot3(testOutput(:, 1), ...
      testOutput(:, 2), ...
      testInput(:, 1), ...
      'r-');
