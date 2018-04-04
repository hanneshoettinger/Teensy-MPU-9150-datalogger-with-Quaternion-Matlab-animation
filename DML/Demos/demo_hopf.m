function demo_hopf
%DEMO_HOPF Demo of Hopf's axis/angle representation of quaternions.

% Note: red line is the X axis

%--------------------------------------------------------------------------
% Test 0 (problematic)
%--------------------------------------------------------------------------
q = [0.4503   -0.7791   -0.1323    0.4156]
[axis angle] = q_getHopfAxisAngle(q);
q_back = q_getFromHopfAxisAngle(axis, angle)

%--------------------------------------------------------------------------
% Test 1 (easy to visualize)
%--------------------------------------------------------------------------
axis = [1 1 0];
axis = axis ./ norm(axis);
angle = deg2rad(95);

q = q_getFromHopfAxisAngle(axis, angle);
displayQuaternions(q);
plot3(axis(1), axis(2), axis(3), 'b.');

[axis2 angle2] = q_getHopfAxisAngle(q);

[axis angle], [axis2 angle2] % Display to compare values

%--------------------------------------------------------------------------
% Test 2 (random)
%--------------------------------------------------------------------------
for i = 1:4
  % Get random parameters
  axis = v3_getRandom();
  angle = getRandom_uniform(0, 2 * pi);

  q = q_getFromHopfAxisAngle(axis, angle);
  [axis2 angle2] = q_getHopfAxisAngle(q);

  [axis angle], [axis2 angle2] % Display to compare values
  %displayVectors3([axis ; axis2]);
end

%--------------------------------------------------------------------------
% Check the uniform distribution of angles
%--------------------------------------------------------------------------
nIterations = 10000;
angles = zeros(1, nIterations);
for i = 1:nIterations
  q = q_getRandom();
  [axis angle] = q_getHopfAxisAngle(q);
  angles(i) = angle;
end
figure(); hist(angles, 50);

%--------------------------------------------------------------------------
% Show neighbours in the space of Hopf descriptors
%--------------------------------------------------------------------------
q = q_getRandom();
displayQuaternions(q);
[axis angle] = q_getHopfAxisAngle(q);
qs = zeros(10, 4);
for i = 1:40
  % Get a close neighbour in the space of Hopf descriptors
  axis2 = v3_getRandom_VMF(axis, 256);
  %displayVectors3([axis; axis2]), pause;
  angle2 = getRandom_triangular(angle, deg2rad(10));
  q2 = q_getFromHopfAxisAngle(axis2, angle2);

  qs(i, 1:4) = q2; % Save it
end
% Display the neighbours
displayQuaternions(qs);
