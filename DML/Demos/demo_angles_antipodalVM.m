function demo_angles_antipodalVM
%DEMO_ANGLES_ANTIPODALVM Demo of the von Mises distribution.

% Get test points
pts = -pi:pi/100:pi; % In radians
ptsDeg = rad2deg(pts); % In degrees

figure, hold all;

% Get the probabilities then plot the result
probabilities = getPdf_antipodalVM(pts, 0, 64); % Antipodal VM distribution
plot(ptsDeg, probabilities, 'k-');

probabilities = getPdf_VM(pts, 0, 64); % Non-antipodal VM distribution
plot(ptsDeg, probabilities, 'g-');
