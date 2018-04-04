function demo_inverseFunction
%DEMO_INVERSEFUNCTION Demo of the approximation of the inverse of a function.

% Solve for x in f(x) = c
% with f(x) = sin(x) - x

f = @(x)(sin(x) - x);

x_groundTruth = getRandom_uniform(0, 2 * pi);
c = f(x_groundTruth);
x = approximateInverseFunction(f, c, 0, 2 * pi, 10);

% Display result
f(x)
f(x_groundTruth)
x
x_groundTruth
