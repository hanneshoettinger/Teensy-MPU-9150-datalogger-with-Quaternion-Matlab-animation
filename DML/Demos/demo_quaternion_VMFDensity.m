function demo_quaternion_VMFDensity()
%DEMO_QUATERNION_VMFDENSITY Demo of the estimation of density in von Mises-Fisher distribution on S3.

% Get a random mean and visualize it
qMean = q_getRandom();
displayQuaternions(qMean);
pause

% Get other random quaternions
for i = 1:10000
  q = q_getRandom();

  % Get the probability density at that orientation
  p = q_getPdf_VMF(q, qMean, 50);
  %p = q_getPdf_VMFApproximation(q, qMean, deg2rad(10));
  %p = q_getPdf_antipodalVMF(q, qMean, 32);

  % Display it
  orientationLineLength = p;
  if orientationLineLength > 0.01 % Skip practically invisible orientations
    displayOneQuaternions(q, orientationLineLength);
  end
end

end

function displayOneQuaternions(q, orientationLineLength)
  lineStart = [0 0 0];
  lineEnd = [0 0 0];

  % Orientation line in X orientation
  lineEnd = q_rotatePoint(orientationLineLength * [1 0 0], q(1, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'r-');


  % Orientation line in Y orientaton
  lineEnd = q_rotatePoint(orientationLineLength * [0 1 0], q(1, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'b-');

  % Orientation line in Z orientaton
  lineEnd = q_rotatePoint(orientationLineLength * [0 0 1], q(1, :));
  plot3([lineStart(1) lineEnd(1)], ...
        [lineStart(2) lineEnd(2)], ...
        [lineStart(3) lineEnd(3)], 'k-');
end
