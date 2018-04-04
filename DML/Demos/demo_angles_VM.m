function demo_angles_VM
%DEMO_ANGLES_VM Demo of the von Mises distribution.

% Get test points
pts = -pi:pi/100:pi; % In radians
ptsDeg = rad2deg(pts); % In degrees

figure, hold all;

% Get the probabilities then plot the result for different values of kappa
probabilities = getPdf_VM(pts, 0, 16);
plot(ptsDeg, probabilities, 'y-');

probabilities = getPdf_VM(pts, 0, 32);
plot(ptsDeg, probabilities, 'b-');

probabilities = getPdf_VM(pts, 0, 64);
plot(ptsDeg, probabilities, 'k-');

probabilities = getPdf_VM(pts, 0, 128);
plot(ptsDeg, probabilities, 'g-');

probabilities = getPdf_VM(pts, 0, 256);
plot(ptsDeg, probabilities, 'r-');

%probabilities = normpdf(pts, 0, deg2rad(20)); % Normal distribution
%plot(ptsDeg, probabilities, 'ko');

% Evaluate the integral of the PDF on [-pi,pi]
integral = quad(@(x) getPdf_VM(x, 0, 64), ...
           -pi, pi)
