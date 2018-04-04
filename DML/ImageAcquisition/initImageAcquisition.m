function videoInput = initImageAcquisition()
%INITIMAGEACQUISITION Initialize image acquisition.
%   VIDEOINPUT = INITIMAGEACQUISITION() opens an interface to a capture
%   device and configure it with basic parameters. The function returns an
%   object just like the videoinput() function does. This object can then
%   be used with functions such as PREVIEW(VIDEOINPUT) and
%   GETSNAPSHOT(VIDEOINPUT).
%
%   Requires the Image acquisition toolbox.

%   Author: Damien Teney

% Open interface to the camera
%videoInput = videoinput('winvideo', 1, 'YUY2_640x480');
%videoInput = videoinput('winvideo', 1);
videoInput = videoinput('avtmatlabadaptor64_r2009b', 1, 'RGB8_1280x960_Binning_1x1');

% Useful commands
%{
imaqtool()
imaqhwinfo('winvideo', 1)
get(getselectedsource(videoInput)) % Properties of the video source
%}

% Set parameters of the video input
videoInput.ReturnedColorspace = 'rgb';
videoInput.FramesPerTrigger = 1;
videoInput.TriggerRepeat = Inf;

% Set parameters of the capture device (eg. a camera)
src = getselectedsource(videoInput);
%src.BacklightCompensation = 'off';
%src.Brightness = 0;
%src.Gamma = 100;
%src.Hue = 0;
%src.Saturation = 64;
%src.Sharpness = 0;
