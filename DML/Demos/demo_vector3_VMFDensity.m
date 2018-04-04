function demo_vector3_VMFDensity()
%DEMO_VECTOR3_VMFDENSITY Demo of the estimation of density in von Mises-Fisher distribution on S2.

% Get a random mean and visualize it
vMean = v3_getRandom();
displayVectors3(vMean);
%displaySpheres([0 0 0], 1);
pause

% Get other random vectors
for i = 1:1000
  v = v3_getRandom();

  % Get the probability density at that orientation
  %p = v3_getPdf_VMF(v, vMean, 10);
  p = v3_getPdf_antipodalVMF(v, vMean, 48);

  % Display it
  orientationLineLength = p;
  if orientationLineLength > 0.0001 % Skip practically invisible orientations
    displayOneVector3(v, orientationLineLength);
  end
end

end

function displayOneVector3(v, orientationLineLength)
  lineStart = [0 0 0];
  lineEnd = orientationLineLength * v(1, :);

  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'r-');
end
