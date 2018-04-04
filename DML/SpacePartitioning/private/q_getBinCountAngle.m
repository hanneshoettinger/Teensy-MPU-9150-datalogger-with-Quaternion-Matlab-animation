function binCount2 = q_getBinCountAngle(binCount1)
%Q_GETBINCOUNTANGLE Number of bins for the S1 part of a quaternion.

%   Author: Damien Teney

% We want:
%     sqrt((4 * pi) / binCount1) = (2 * pi) / binCount2
% <=> binCount2 = sqrt(binCount1 / (4 * pi)) * 2 * pi
% (see Yershova's paper, Eq. 9)
binCount2 = round(sqrt(binCount1 / (4 * pi)) * 2 * pi);
