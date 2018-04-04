function demo_quaternionAverage
%DEMO_QUATERNIONAVERAGE Demo of the averaging of quaternions.

% Get a few random (close) quaternions
%{
qs = zeros(3, 4);
qs(1, 1:4) = q_getRandom();
qs(2, 1:4) = q_getRandom_VMF(qs(1, 1:4), 128);
qs(3, 1:4) = q_getRandom_VMF(qs(1, 1:4), 64);
qs(4, 1:4) = q_getRandom_VMF(qs(1, 1:4), 64);
qs(5, 1:4) = q_getRandom_VMF(qs(1, 1:4), 64);
qs(6, 1:4) = q_getRandom_VMF(qs(1, 1:4), 64);
qs(7, 1:4) = q_getRandom_VMF(qs(1, 1:4), 64);
%}

% Tricky test case
% (quaternions in different half-parts of R4 (cf double cover of SO(3) by the quaternions))
%%{
qs=[-0.2266    0.2554    0.3625   -0.8672;
    -0.2251    0.2666    0.3667   -0.8624;
     0.2423   -0.2913   -0.3583    0.8533;
     0.2482   -0.2955   -0.3711    0.8446];
%}

% Display the quaternions
displayQuaternions(qs);

% Get the avergae
% Todo
average = q_getAverage(qs);

% Display the average
displayQuaternions([qs ; average]);

% Display the angle between the average and each quaternion
for i = 1:size(qs, 1)
  rad2deg(q_getAngleDifference(average, qs(i, 1:4)))
end
