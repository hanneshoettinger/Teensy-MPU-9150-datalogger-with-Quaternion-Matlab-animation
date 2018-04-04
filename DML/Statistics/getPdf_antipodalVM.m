function p = getPdf_antipodalVM(alpha, mean, kappa)
%GETPDF_ANTIPODALVM Probability in a pair of antipodal von Mises distributions.
%   P = GETPDF_ANTIPODALVM(ALPHA, MEAN, KAPPA) returns the probability
%   density of the angle ALPHA (in radians) in a symmetrical von Mises
%   distribution of preferred direction MEAN (default is 0) and
%   concentration KAPPA (default is 1).
%
%   The parameter ALPHA can also contain several angles (dimension 1xN),
%   P is then of dimension 1xN.

%   Author: Damien Teney

% Check the arguments
if nargin < 3
  kappa = 1;
end
if nargin < 2
  mean = 0;
end

% Make sure we have 1xN vectors
alpha = alpha(:)';
mean = mean(:)';

% Evaluate pdf
C = 1 / (2 * pi * besseli(0, kappa));

% Good version
%tmp = (exp(kappa * cos(alpha - mean)) + ...
%       exp(kappa * cos(shiftedAlpha - mean))) ...
%      / 2;

% Other (simpler) version
cosTmp = abs(cos(alpha - mean));
tmp = exp(kappa * cosTmp);

p = C * tmp / 2;
