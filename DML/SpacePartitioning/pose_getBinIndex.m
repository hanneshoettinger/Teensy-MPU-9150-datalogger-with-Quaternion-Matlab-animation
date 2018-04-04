function binIndex = pose_getBinIndex(pose)
%POSE_GETBININDEX  Bin index from 3D pose.
%   BININDEX = POSE_GETBININDEX(POSE) divides the space of 3D poses into
%   bins of similar shape and area (at a hard-coded resolution), and
%   determines in which the given pose falls.

%   Author: Damien Teney

% Position part of the pose
position = pose(1:3);

% Orientation part of the pose
q = pose(4:7);
orientationResolution = 2;

% Separate the quaterion into 2 elements
[qAxis qAngle] = q_getHopfAxisAngle(q);

% Get the number of bins for qAxis and qAngle
binCountVector3 = v3_getBinCount(orientationResolution);
binCountAngle = q_getBinCountAngle(binCountVector3);

% Get the bin index for the whole pose
binIndex = v_getBinIndex(...
  [qAngle        v3_getBinIndex(qAxis, orientationResolution) position(3) position(2) position(1)], ...
  [0             0                                            -101        -50         -50        ], ...
  [(2 * pi)      binCountVector3                              -99         +50         +50        ], ...
  [binCountAngle binCountVector3                              10          10          1          ]  ...
);

% Debug display
%{
q
[position(3), position(2), position(1)]
qAxis
qAngle
binCountVector3
binCountAngle
v3_getBinIndex(qAxis, orientationResolution)
%}
