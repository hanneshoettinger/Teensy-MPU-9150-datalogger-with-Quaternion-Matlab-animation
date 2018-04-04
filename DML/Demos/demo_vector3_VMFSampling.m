function demo_vector3_VMFSampling
%DEMO_VECTOR3_VMFSAMPLING Demo of the sampling of a von Mises-Fisher distribution on the 2-sphere.

% Get a random mean and visualize it
v = v3_getRandom();
displayVectors3(v);

% Get random samples
vs = zeros(100, 3);
for i = 1:size(vs, 1)
  %vs(i, 1:3) = v3_getRandom_VMF(v, 128);
  vs(i, 1:3) = v3_getRandom_antipodalVMF(v, 128);
end

% Visualize the samples
displayVectors3(vs);

% Get the angles between the mean and the samples
angles = v3_getAngleBetweenVectors(v, vs);
figure, hist(angles);
