function demo_triangularDistribution
%DEMO_TRIANGULARDISTRIBUTION  Demo of the multivariate triangular distribution.

% Generate test points
testPoints = [];
lineIndex = 1;
for x = 0:.25:10
  for y = 0:.25:10
    testPoints(lineIndex, 1:2) = [x y];
    lineIndex = lineIndex + 1;
  end
end

% Compute probabilities
P = getPdf_triangular(testPoints, [5 5], 3); % Triangular distribution
%P = mvnpdf(testPoints, [5 5], eye(2)); % Normal distribution

% Plot the results
figure, hold all;
plot3(testPoints(:, 1), ...
      testPoints(:, 2), ...
      P, 'b.');
