function demo_quaternion_VMFSampling
%DEMO_QUATERNION_VMFSAMPLING Demo of the sampling of a von Mises-Fisher distribution on the 2-sphere.

% Get a random mean and visualize it
%qMu = q_getRandom();
qMu = [0.8703 -0.4847 0.0819 -0.0303];
displayQuaternions(qMu);

% Get random samples
qs = zeros(1000, 4);
for i = 1:size(qs, 1)
  sample = q_getRandom_VMF(qMu, 128);
  qs(i, 1:4) = sample;
  angleDifferences(i) = q_getAngleDifference(sample, qMu);
end

% Visualize the samples
displayQuaternions(qs);

% Display the distribution of angles around the mean
figure(); hist(angleDifferences);
