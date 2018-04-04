function demo_meanRotationError
%DEMO_MEANROTATIONERROR Demo of the mean error on rotation.

% Get a random mean and visualize it
q1 = q_getRandom();
%displayQuaternions(q1);

% Get random samples
qs = zeros(10000, 4);
for i = 1:size(qs, 1)
  qs(i, 1:4) = q_getRandom();
  [trash errors(i)] = getPoseDifference([0 0 0 q1], ...
                                        [0 0 0 qs(i, 1:4)]);
end

% Visualize the samples
%displayQuaternions(qs);

% Visualize the errors
figure, hist(errors, 20);
mean(errors)
