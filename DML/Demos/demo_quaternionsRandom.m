function demo_quaternionsRandom
%DEMO_QUATERNIONRANDOM Demo of random quaternions.

displayPoses([], true, '.');

for i = 1:1000
  q = q_getRandom();
  displayPoses([0 0 0 q], false, '.');
end
